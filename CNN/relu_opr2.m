function [outputArg2] = relu_opr2(Ctest)

for zt = 1:8  
    for xt = 1:51
        for yt = 1:51
            at = Ctest(xt,yt,zt);
            if at < 0
               Ctest(xt,yt,zt) = 0; 
            end
        end
    end
end

outputArg2 = Ctest;

end
