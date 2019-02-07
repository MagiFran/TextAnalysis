library(dplyr)
library(tidytext)
library(ggplot2)
library(wordcloud)


CMB <- read.csv("D:/Data_Input/TextAnalysis/CustomerSMS.csv")

CMBVal <- as.character(CMB$MSG)

#note that line must equal the observations in ELB

text_df <- data_frame(line = 1:37450, text = CMBVal )


tidy_CMB <- text_df %>% unnest_tokens(word, text)

data("stop_words")

tidy_CMB <- tidy_CMB %>%
  anti_join(stop_words)

CMB_WordCount <- tidy_CMB %>% count(word, sort = TRUE) 


#need to do stemming an synonyms

tidy_CMB %>%
  count(word, sort = TRUE) %>%
  filter(n > 600) %>%
  mutate(word = reorder(word, n)) %>%
  ggplot(aes(word, n)) +
  geom_col() +
  xlab(NULL) +
  coord_flip()

write.csv(CMB_WordCount,"D:/Data_Input/TextAnalysis/CMBWords.csv")

wordcloud(CMB_WordCount$word,CMB_WordCount$n)


