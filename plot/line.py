import matplotlib.pyplot as plt

x = [i for i in range(1, 24)]
y_on = [
    1.8     ,
    1.852   ,
    1.874   ,
    1.894   ,
    1.906   ,
    1.916   ,
    1.948   ,
    1.994   ,
    2.066   ,
    2.224   ,
    2.542   ,
    3.156   ,
    4.072   ,
    5.92    ,
    9.546   ,
    17.44   ,
    37.316  ,
    109.698 ,
    318.134 ,
    839.978 ,
    2035.862,
    4497.364,
    9113.180,
]

err_on = [
    0.014142136,
    0.033466401,
    0.02607681 ,
    0.025099801,
    0.015165751,
    0.015165751,
    0.014832397,
    0.016733201,
    0.019493589,
    0.020736441,
    0.022803509,
    0.025099801,
    0.021679483,
    0.226384628,
    0.793996222,
    2.179793568,
    8.139550356,
    31.11962998,
    80.49535036,
    100.4539622,
    55.17564245,
    5.381052871,
    181.8865373,
]


y_off = [
    1.822   ,
    1.852   ,
    1.878   ,
    1.888   ,
    1.908   ,
    1.916   ,
    1.954   ,
    2.004   ,
    2.088   ,
    2.484   ,
    2.96    ,
    3.71    ,
    4.682   ,
    6.588   ,
    10.128  ,
    17.722  ,
    34.15   ,
    75.854  ,
    274.406 ,
    804.864 ,
    1988.482,
    4484.13 ,
    9001.212,
]

err_off = [
    0.019235384,
    0.021679483,
    0.028635642,
    0.019235384,
    0.013038405,
    0.013416408,
    0.008944272,
    0.015165751,
    0.013038405,
    0.528942341,
    0.883515704,
    1.174414748,
    1.242344558,
    1.517323301,
    1.987692129,
    4.088247791,
    7.635793999,
    16.06798463,
    47.97067208,
    66.05817724,
    76.40675409,
    19.28754391,
    238.8354444,
]

# line color
on_color="red"
off_color="green"

plt.xticks([i for i in range(max(x) + 1) ])

# draw line
l_on=plt.plot(x,y_on,color=on_color,label='IOMMU ON')
l_off=plt.plot(x,y_off,color=off_color,label='IOMMU OFF')

# draw dot
plt.plot(x,y_on,color=on_color,marker='o',linestyle='dashed')
plt.plot(x,y_off,color=off_color,marker='o',linestyle='dashed')

# draw error bar
plt.errorbar(x,y_on,yerr=err_on,color=on_color)
plt.errorbar(x,y_off,yerr=err_off,color=off_color)

plt.title("%s-%s" % ("demo", "line"))
plt.xlabel('log(size) (bytes)')
plt.ylabel("avg latency (usec)")
plt.legend()
plt.savefig("%s-%s.png" % ("demo", "line"))
