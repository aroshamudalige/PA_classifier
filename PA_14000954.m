data = dlmread('datafile.csv');
x = data(:,2:11);
for ii = 1:size(x,1) 
  if x(ii,10)==2
    x(ii,10) = -1; 
  else 
    x(ii,10) = 1;  
  end
endfor

X = x(:,1:9);
Y = x(:,10);
train = round(size(x,1)*(2/3)); %spliting dataset for training and testing
test = size(x,1) - train;
X_train = X(1:train,:);
X_test = X(train+1:size(x,1),:);
Y_train = Y(1:train,:);
Y_test = Y(train+1:size(x,1),:);
X = X_train;
Y = Y_train;
count1 = 0; %to calculate training_accuracy
count2 = 0; %to calculate testing_accuracy

prompt1 = 'What is the value of constant C? ';
C = input(prompt1);
prompt2 = 'How many iterations? ';
iterations = input(prompt2);

%training
W = zeros(1,size(X,2));
for a = 1:iterations
  for rows = 1:size(X,1) 
    y_hat = dot(W,X(rows,:));
    loss = max(0,1-(Y(rows,1)*y_hat));
    if loss==0
      count1 = count1 + 1;   
    end
    training_accuracy = (count1/size(X,1)) * 100;
    jt = min(C, loss/(norm(X(rows,:)))^2); %PA-I
    W = W + jt*Y(rows,1)*X(rows,:);
  endfor
  count1 = 0;
endfor

%testing
for rows = 1:size(X_test,1) 
  y_hat = dot(W,X_test(rows,:));
  loss = max(0,1-(Y_test(rows,1)*y_hat));
  if loss==0
    count2 = count2 + 1;   
  end
  testing_accuracy = (count2/size(X_test,1)) * 100;
endfor

%printing results
training_accuracy
testing_accuracy
%fields = { 'Clump Thickness', 'Uniformity of Cell Size', 'Uniformity of Cell Shape', 'Marginal Adhesion', 'Single Epithelial Cell Size', 'Bare Nuclei', 'Bland Chromatin' , 'Normal Nucleoli', 'Mitoses'};
W