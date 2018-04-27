#step 1
data = csvread('train.csv');
data(1,:) = [];
X = data(:,1);
Y = data(:,2);
m = length(Y);
X = [ones(m, 1), data(:,1)];

#step 2
w = rand(2,1);

#step 3
figure;
scatter(X(:,2),Y);
hold on;
wXx = X*w;
plot(X(:,2),wXx,'rx');

title('Initial Plot between X*w and Y');
hold off;

#step 4
figure;
a = inv(transpose(X)*X);
c = transpose(X)*Y;
scatter(X(:,2),Y);
hold on;
w_direct = a*c;
w_directXx = X*w_direct;
plot(X(:,2),w_directXx,'rx');

title('Plot between X*w\_direct and Y');
hold off;

#step 5
for epoch = 1:3
  for i = 1:10000
    d = transpose(X(i,:));
    e = transpose(w)*d;
    f = e - Y(i,:);
    w = w - 0.000000001*f*d;
    if mod(i,100) == 0
      figure;
      scatter(X(:,2),Y);
      hold on;
      wXx = X*w;
      plot(X(:,2),wXx,'rx');
      title(['Plot between X*w and Y after ',num2str(epoch),' epochs and ',num2str(i),' iterations']);
      hold off;
    end
  end
end

#step 6
figure;
scatter(X(:,2),Y);
hold on;
wXx = X*w;
plot(X(:,2),wXx,'rx');
title('Final Plot between X*w and Y');
hold off;

#step 7
data2 = csvread('test.csv');
data2(1,:) = [];
X_test = data2(:,1);
Y_test = data2(:,2);
n = length(Y_test);
X_test = [ones(n, 1), data2(:,1)];
y_pred1 = X_test*w;
y_pred2 = X_test*w_direct;
error1 = y_pred1 - Y_test;
error2 = y_pred2 - Y_test;
sqerror1 = transpose(error1)*error1;
sqerror2 = transpose(error2)*error2;
rms1 = sqrt((1/n)*sqerror1);
rms2 = sqrt((1/n)*sqerror2);
fprintf('RMS error between Y_pred1 and Y_test is %i and between Y_pred2 and Y_test is %i',rms1,rms2);

    