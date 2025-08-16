s = int(input("Segundos: "))

if(s < 60):
    h = 0
    m = 0
    print("{:02d}:{:02d}:{:02d}".format(h,m,s))
elif(s >= 60 and s < 3600):
    seg = s % 60
    m = (s - seg) // 60
    h = 0
    print("{:02d}:{:02d}:{:02d}".format(h,m,seg))
else: 
    seg = s % 60
    m = (s // 60) % 60
    h = (s // 60) // 60 
    print("{:02d}:{:02d}:{:02d}".format(h,m,seg))