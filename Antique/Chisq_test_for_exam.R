rm(list=ls())

obesity_diabetes = 10
obesity_normal = 10
normal_diabetes = 15
normal_normal = 65

all = obesity_diabetes + obesity_normal + normal_diabetes + normal_normal 

obesity = obesity_diabetes + obesity_normal
normal = normal_diabetes + normal_normal
diabetes = obesity_diabetes + normal_diabetes
normal = obesity_normal + normal_normal

obesity_diabetes_expect = ((obesity/all) * (diabetes/all)) * all
normal_diabetes_expect = ((normal/all) * (diabetes/all)) * all

obesity_normal_expect = ((obesity/all) * (normal/all)) * all
normal_normal_expect = ((normal/all) * (normal/all)) * all

chi_sq = (obesity_diabetes - obesity_diabetes_expect)**2/obesity_diabetes_expect + 
  (normal_diabetes - normal_diabetes_expect)**2/normal_diabetes_expect +
  (obesity_normal - obesity_normal_expect)**2/obesity_normal_expect +
  (normal_normal - normal_normal_expect)**2/normal_normal_expect

chi_sq

test = data.frame(obesity = c(10,10), normal=c(15,65))
chisq.test(test)
