# =========================================================================
# DEPREM VERI GORSELLESTIRME PROJESI - NIHAI ANALIZ KODLARI
# =========================================================================

# 1. GEREKLI KUTUPHANELER
library(ggplot2)
library(dplyr)
library(tidyr)
library(ggrepel)

# 2. VERI SETINI ICERI AKTARMA
# CSV dosyası ile bu R dosyası aynı klasörde olmalıdır.
df <- read.csv("temizlenmis_deprem_verisi.csv", fileEncoding="UTF-8")

# Mevsim siralamasi
df$Season <- factor(df$Season, levels = c("İlkbahar", "Yaz", "Sonbahar", "Kış"))

# --- GRAFIK 1: Yillara Gore Deprem Buyuklukleri (Kutu Grafigi) ---
df_aykiri <- df %>%
  group_by(Year) %>%
  mutate(
    Q1 = quantile(Magnitude, 0.25),
    Q3 = quantile(Magnitude, 0.75),
    IQR = Q3 - Q1,
    Ust_Sinir = Q3 + 1.5 * IQR,
    Alt_Sinir = Q1 - 1.5 * IQR,
    Aykiri_Mi = Magnitude > Ust_Sinir | Magnitude < Alt_Sinir
  ) %>%
  filter(Aykiri_Mi == TRUE)

plot1 <- ggplot(df, aes(x = as.factor(Year), y = Magnitude)) +
  geom_boxplot(fill = "steelblue", outlier.shape = 18, outlier.size = 2.5, alpha = 0.8) +
  geom_text_repel(data = df_aykiri, aes(label = City), 
                  color = "firebrick", size = 2.5, 
                  box.padding = 0.5, point.padding = 0.3) +
  theme_light() +
  labs(title = "Yillara Gore Deprem Buyuklukleri (Kutu Grafigi)",
       x = "Yil", y = "Buyukluk") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1),
        plot.title = element_text(hjust = 0.5, size = 15))

# --- GRAFIK 2: Derinlik ve Buyukluk Iliskisi (Sacilim Grafigi) ---
plot2 <- ggplot(df, aes(x = Depth, y = Magnitude)) +
  geom_point(color = "steelblue", size = 2, alpha = 0.9) + 
  scale_y_continuous(breaks = seq(5.0, 8.0, by = 0.1)) + 
  theme_bw() + 
  labs(title = "Derinlik ve Buyukluk Iliskisi (Sacilim Grafigi)", 
       x = "Derinlik (km)", 
       y = "Buyukluk (Mw/ML vs)") +
  theme(plot.title = element_text(hjust = 0.5, size = 14))

# --- GRAFIK 3: Mevsimlere Gore Deprem Sayilari ---
plot3 <- ggplot(df, aes(x = Season, fill = Season)) +
  geom_bar(alpha = 0.9) +
  geom_text(stat = "count", aes(label = paste0("n=", after_stat(count))), 
            vjust = -0.5, size = 4.5, color = "black") +
  scale_fill_brewer(palette = "Pastel1") + 
  scale_y_continuous(expand = expansion(mult = c(0.05, 0.15))) +
  theme_light() + 
  labs(title = "Mevsimlere Gore Deprem Sayilari", 
       x = "Mevsim", 
       y = "Deprem Sayisi") +
  theme(plot.title = element_text(hjust = 0.5, size = 14), 
        legend.position = "none") 

# --- GRAFIK 4: Yil ve Aylara Gore Deprem Yogunlugu (Isi Haritasi) ---
df$Month_Num <- format(as.Date(df$Date, format="%d/%m/%Y"), "%m")
df$Month <- factor(df$Month_Num, 
                   levels = c("01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12"),
                   labels = c("Oca", "Sub", "Mar", "Nis", "May", "Haz", "Tem", "Agu", "Eyl", "Eki", "Kas", "Ara"))

heatmap_data <- df %>%
  group_by(Year, Month) %>%
  summarise(Count = n(), .groups = "drop") %>%
  complete(Year, Month, fill = list(Count = 0))

plot4 <- ggplot(heatmap_data, aes(x = Month, y = factor(Year, levels = sort(unique(Year), decreasing = TRUE)), fill = Count)) +
  geom_tile(color = "white", linewidth = 0.3) +
  scale_fill_gradientn(
    colors = c("#D6EEF8", "#9BD0F5", "#5BAEE0", "#3A6FBF", "#6852D1", "#C01483", "#F17D0D", "#DF2C04"),
    values  = scales::rescale(c(0, 5, 10, 15, 20, 30, 40, 50)),
    limits  = c(0, 50),
    name    = "Deprem\nSayisi"
  ) +
  annotate("text", x = "Agu", y = "1999", label = "17 Agustos\nMarmara", size = 1.8, fontface = "bold") +
  annotate("text", x = "May", y = "2003", label = "1 Mayis\nBingol", size = 1.8, fontface = "bold") +
  annotate("text", x = "May", y = "2011", label = "19 Mayis\nSimav", size = 1.8, fontface = "bold") +
  annotate("text", x = "Eki", y = "2011", label = "23 Ekim\nVan", size = 1.8, color = "white", fontface = "bold") +
  annotate("text", x = "Oca", y = "2020", label = "24 Ocak\nElazig", size = 1.8, fontface = "bold") +
  annotate("text", x = "Eki", y = "2020", label = "30 Ekim\nIzmir", size = 1.8, fontface = "bold") +
  annotate("text", x = "Sub", y = "2023", label = "6 Subat\nK.Maras", size = 2.0, color = "white", fontface = "bold") +
  labs(title = "Yil ve Aylara Gore Deprem Yogunlugu", x = "Ay", y = "Yil") +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5, size = 14, face = "bold"),
        panel.grid = element_blank())

# --- GRAFIK 5: Deprem Buyukluk Dagilimi ---
plot5 <- ggplot(df, aes(x = Magnitude)) +
  geom_histogram(aes(y = after_stat(count)), binwidth = 0.2, fill = "#B37EBA", color = "white", alpha = 0.9) +
  geom_density(aes(y = after_stat(count) * 0.2), color = "purple", linewidth = 1) +
  theme_light() + 
  labs(title = "Deprem Buyukluk Dagilimi", x = "Buyukluk", y = "Frekans (Deprem Sayisi)") +
  theme(plot.title = element_text(hjust = 0.5, size = 14))

# --- GRAFIK 6: Bolgelere Gore Ortalama Buyukluk ---
df_bolge_ozet <- df %>%
  group_by(Region) %>%
  summarise(Ortalama = mean(Magnitude, na.rm = TRUE), Sayi = n()) %>%
  arrange(Ortalama) %>%
  mutate(Region = factor(Region, levels = Region))

plot6 <- ggplot(df_bolge_ozet, aes(x = Ortalama, y = Region, fill = Region)) +
  geom_col(alpha = 0.9) +
  coord_cartesian(xlim = c(5, 7)) + 
  geom_text(aes(label = sprintf("%.2f (n=%d)", Ortalama, Sayi)), 
            hjust = -0.1, size = 4, color = "black") +
  scale_fill_viridis_d(option = "viridis", direction = -1) +
  theme_light() +
  labs(title = "Bolgelere Gore Ortalama Deprem Buyuklugu",
       x = "Ortalama Buyukluk", y = "Bolge") +
  theme(plot.title = element_text(hjust = 0.5, size = 15, face = "bold"),
        legend.position = "none")

# TUM GRAFIKLERI CIZDIR
print(plot1)
print(plot2)
print(plot3)
print(plot4)
print(plot5)
print(plot6)
