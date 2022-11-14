def wordCloud():
    
   file_contents = ["Hey", "Hello", "Hi", "Hey", "Hey", "Greetings", "Hi!", "H3y", "Greetings"]
    
   punctuations = '''!()-[]{};:'"\,<>./?@#$%^&*_~'''
   uninteresting_words = ["the", "a", "to", "if", "is", "it", "of", "and", "or", "an", "as", "i", "me", "my", "we", "our", "ours", "you", "your", "yours", "he", "she", "him", "his", "her", "hers", "its", "they", "them", "their", "what", "which", "who", "whom", "this", "that", "am", "are", "was", "were", "be", "been", "being",
   "have", "has", "had", "do", "does", "did", "but", "at", "by", "with", "from", "here", "when", "where", "how",
   "all", "any", "both", "each", "few", "more", "some", "such", "no", "nor", "too", "very", "can", "will", "just"]
    
   # LEARNER CODE START HERE
   # CODE FROM PYTHON COURSERA PROJECT FOR "CRASH COURSE ON PYTHON"
   # FOR WORDCLOUD
    
   dict = {}
  
   for word in file_contents:
     if word.isalpha():
         if word in dict.keys():
            dict[word] += 1
         else:
             for special in punctuations:
                if not special in word:
                    if not word in uninteresting_words:
                        dict[word] = 1
   return dict

print(wordCloud())
