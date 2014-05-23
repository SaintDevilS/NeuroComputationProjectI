function [W1,W2] = train_nn(input,W1,W2)

%Sizes
Firstlayer=10;
Hiddenlayer=7;
Meo =0.4;
Iter= 500;
%Initilaized weights if needed 
Xin=input;

if (isnan(W2) || isnan(W2))
    W1=rand(Firstlayer,Hiddenlayer);
    W2=rand(Hiddenlayer,Firstlayer);
end

%Predict
k=10;
for i=1:Iter;
    Yhidden =round( 1 ./ (1+ exp(-k*(Xin *W1 ))));
    Yout =round( 1 ./ (1+ exp(-k*( Yhidden *W2 ))));
    %Derviative
    D2=diag(Yout*(1-Yout));
    D1=diag(Yhidden*(1-hidden));
    
    error = input-Yout; %may need squared error -!
    d2= D2 * error;
    d1= D1 * W1 * d2;

    W1 = W1 - Meo * d1 * input ;
    W2 = W2 - Meo * d2 * Yhidden;
end


