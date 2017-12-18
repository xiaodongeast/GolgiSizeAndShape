function [ft]= show(hisM,bin)
[m,n]=size(hisM);
for i=1:n
 bar(bin,hisM(:,i))
    
     axis manual;
 
    ylim([0,3000]);
    ft(i)=getframe(gcf);
    hold;
end

end
