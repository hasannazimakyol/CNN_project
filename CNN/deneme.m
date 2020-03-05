% Trying Max Pooling Nested Loop
% temp=0; %Temporary variable for stride
% tmpX=0;
% tmpY=0;

% for za = 1:length(C)
%    for xa = 1:size(C,1)

%  
% for za = 1:length(C)
%      for xa=1:round(size(C,1)/5)
%          for ya=1:round(size(C,2)/5)
%              for cx=1:5
%                  for cy=1:5
%                      stride by 5
%                      cya = cy+tmpY;
%                      cxa = cx+tmpX;
%                      if C(cx,cy,za)>temp
%                          temp = C(cya,cxa,za);
%                      end
%                  end
%              end
%              if ya == size(C,2)/5
%                  tmpY=0;
%                  tmpX=tmpX+5;
%              else
%                 tmpY=tmpY+5;
%              end
%          end
%      end
% end

% errorLayer = sym(zeros(size(outLayer,1),length(outLayer)));
% for i=1:length(outLayer)
%     for h=1:size(outLayer,1)
%         L = -log(outLayer(h,i))
%         errorLayer(h,i) = L
%     end
% end