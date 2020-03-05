clear all;
clc;
close;

%% Loading Data
load('images.mat');
load('DesiredValuesVactor.mat');
load('test_images.mat');
 
%%

filter = [0 1 0;1 -4 1;0 1 0];  %Kernel edge filter
weights = randn(3,100); %Set initial weights
sOuts = zeros(1,3); % Gradient of output's array is created.

C = convn(inpM,filter,'same');  %Convolution process

%% Relu operation
C = relu_opr(C);

%% Max Pooling 

dlX = dlarray(C,'SSCB');
dlY = maxpool(dlX,5,'Stride',5);

%% Flattening

inpLayer = reshape(dlY,(size(dlY,1)*size(dlY,2)),length(dlY));

%% Input Iteration

for i=1:60


    V0 = dotprod(weights,inpLayer(:,i)); % Weights and inputs was multiplied

    V = dlarray(V0,'CB'); % V0's dlarray is converted to available dlarray.

    outLaye = softmax(V); % Applying softmax function
    
    outLayer = extractdata(outLaye);
    
    
    %% Output Gradient calculation
    
    y = outLayer(desV(i));          
    s = exp(V(1))+exp(V(2))+exp(V(3));
    
    if desV(i)==1        
        sOuts(1) = extractdata(-((-1)/y).*((exp(V(1)).*(s-V(1)))/s^2)); 
        sOuts(2) = extractdata(-((-1)/y).*(-(exp(V(1)).*(exp(V(2))))/s^2));
        sOuts(3) = extractdata(-((-1)/y).*(-(exp(V(1)).*(exp(V(3))))/s^2));
    elseif desV(i)==2
        sOuts(1) = extractdata(-((-1)/y).*(-(exp(V(2)).*(exp(V(1))))/s^2));
        sOuts(2) = extractdata(-((-1)/y).*((exp(V(2)).*(s-V(2)))/s^2));
        sOuts(3) = extractdata(-((-1)/y).*(-(exp(V(2)).*(exp(V(3))))/s^2));
    else
        sOuts(1) = extractdata(-((-1)/y).*(-(exp(V(3)).*(exp(V(1))))/s^2));
        sOuts(2) = extractdata(-((-1)/y).*(-(exp(V(3)).*(exp(V(2))))/s^2));
        sOuts(2) = extractdata(-((-1)/y).*((exp(V(3)).*(s-V(3)))/s^2));
    end
        
    %%    
            
    sInpList = zeros(1,100); % Gradient of input's array is created.
        
        for z=1:size(weights,2)
           sInpList(z) = (weights(1,z)*sOuts(1))+(weights(2,z)*sOuts(2))+(weights(3,z)*sOuts(3)); % Gradient of input's array is calculated. 
        end
        

        
    inpLayer1 = extractdata(inpLayer);   %Extracting dlarray to double array.
    inpLayerT = transpose(inpLayer1);    %Transpose for appropriate production
    sOutsT = transpose(sOuts);           %Transpose for appropriate production

               
    newWeights = weights+((0.1).*(sOutsT.*inpLayerT(i,:)));
    weights = newWeights;
    
end         

%% Testing  %We cannot fix this part.

%for asd:size(test,3)
    
    % Ctest = convn(test,filter,'same');  %Convolution process
    % 
    % %% Relu operation
    % 
    % %Ctest = relu_opr2(Ctest); 
    % 
    % %% Max Pooling 
    % 
    % dlXtest = dlarray(Ctest,'SSCB');
    % dlYtest = maxpool(dlXtest,5,'Stride',5);
    % 
    % %% Flattening
    % 
    % inpLayertest = reshape(dlYtest,(size(dlYtest,1)*size(dlYtest,2)),length(dlYtest));
    %      
    % V0test = dotprod(weights,inpLayertest(:,i)); % Weights and inputs was multiplied
    % 
    % Vtest = dlarray(V0test,'CB'); % V0's dlarray is converted to available dlarray.
    % 
    % outLayetest = softmax(Vtest); % Applying softmax function
    % 
    % outLayertest = extractdata(outLayetest);











