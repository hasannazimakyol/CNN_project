function [outputArg1] = relu_opr(C)

for z = 1:length(C)  
    for x = 1:size(C,1)
        for y = 1:size(C,2)
            a = C(x,y,z);
            if a < 0
               C(x,y,z) = 0; 
            end
        end
    end
end

outputArg1 = C;

end

