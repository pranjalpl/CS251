import numpy as np
import matplotlib.pyplot as plt

from numpy import genfromtxt
input = genfromtxt('Assignment-3/train.csv', delimiter=',')
input = np.delete(input, (0), axis=0)

x_train = np.delete(input, (1), axis=1)
y_train = np.delete(input, (0), axis=1)
x_train = np.insert(x_train, 0, 1, axis=1)

w = np.random.rand(2,1)
wXx = np.matmul(x_train,w)

plt.scatter(x_train[:,1],y_train,marker='^',s=.00001)
plt.plot(x_train[:,1],wXx,'ro')
plt.title('Raw Data and Initial X*w')
plt.show()

a = np.matmul(np.transpose(x_train),x_train)
b = np.linalg.inv(a)
c = np.matmul(np.transpose(x_train),y_train)
w_direct = np.matmul(b,c)

w_directXx = np.matmul(x_train,w_direct)
plt.scatter(x_train[:,1],y_train,marker='^',s=.00001,alpha=.5,c='g')
plt.plot(x_train[:,1],w_directXx, 'b.')
plt.title('Raw Data and Initial X*w_direct')
plt.show()

alpha = 0.00001
m = y_train.shape[0]
for i in (1,5):
    for j in range (1,m):
        p = np.reshape(x_train[j,:],(2,1))
        q = np.matmul(np.reshape(w,(1,2)),p)
        r = np.subtract(q,y_train[j,:])
        s = np.multiply(r,np.reshape(x_train[j,:],(2,1)))
        t = (alpha/m)*s
        w = np.subtract(w,t)
        if(j%100 == 0):
            plt.scatter(x_train[:,1],y_train,marker='^',s=.00001)
            wXx1 = np.matmul(x_train,w)
            plt.plot(x_train[:,1],wXx1,'ro')
            plt.title('Raw Data and X*w after %d steps'%(j))
            plt.show()


wXx2 = np.matmul(x_train,w)
plt.scatter(x_train[:,1],y_train,marker='^',s=.00001)
plt.plot(x_train[:,1],wXx2,'ro')
plt.title('Final X*w')
plt.show()

input2 = genfromtxt('Assignment-3/test.csv', delimiter=',')
input2 = np.delete(input, (0), axis=0)

x_test = np.delete(input2, (1), axis=1)
y_test = np.delete(input2, (0), axis=1)
x_test = np.insert(x_test, 0, 1, axis=1)

y_pred1 = np.matmul(x_test,w)
diff1 = np.subtract(y_pred1,y_test)
diff1t = np.reshape(diff1,(1,y_test.shape[0]))
sqdiff1 = np.matmul(diff1t,diff1)
sqdiff1mean = (1/y_test.shape[0])*sqdiff1
rms1 = np.sqrt(sqdiff1mean)

print('ypred1 error:')
print(float(rms1))

y_pred2 = np.matmul(x_test,w_direct)
diff2 = np.subtract(y_pred2,y_test)
diff2t = np.reshape(diff2,(1,y_test.shape[0]))
sqdiff2 = np.matmul(diff2t,diff2)
sqdiff2mean = (1/y_test.shape[0])*sqdiff2
rms2 = np.sqrt(sqdiff2mean)

print('ypred2 error:')
print(float(rms2))