rm(list=ls())

man_galaxy = 72
man_iphone = 55
woman_galaxy = 28
woman_iphone = 67

all = man_galaxy + man_iphone + woman_galaxy + woman_iphone 

man = man_galaxy + man_iphone
woman = woman_galaxy + woman_iphone
galaxy = man_galaxy + woman_galaxy
iphone = man_iphone + woman_iphone

man_glaxy_expect = ((man/all) * (galaxy/all)) * all
woman_glaxy_expect = ((woman/all) * (galaxy/all)) * all

man_iphone_expect = ((man/all) * (iphone/all)) * all
woman_iphone_expect = ((woman/all) * (iphone/all)) * all

chi_sq = (man_galaxy - man_glaxy_expect)**2/man_glaxy_expect + 
  (woman_galaxy - woman_glaxy_expect)**2/woman_glaxy_expect +
  (man_iphone - man_iphone_expect)**2/man_iphone_expect +
  (woman_iphone - woman_iphone_expect)**2/woman_iphone_expect

chi_sq

test = data.frame(man = c(72,55), woman=c(28,67))
chisq.test(test)
