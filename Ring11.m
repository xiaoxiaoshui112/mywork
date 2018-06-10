

x0=50:5:150;
y0=50:5:150;
for i=1:21
    for j=1:21
        A(i,j,1)=x0(i);
         A(i,j,2)=y0(j);
    end
   
end
file=dir('E:\Ring\Ring_150_70\Ring\right\*.txt');
B=cell(21,21);
for n=1:length(file)
    temp=dlmread(['E:\Ring\Ring_150_70\Ring\right\',file(n).name]);
    ms=regexp( file(n).name, '(?<=\w+)\d+', 'match' );
   m1=str2num( ms{ 1 } );
   n1=str2num( ms{ 2 } );
   for i=1:21
    for j=1:21
       if A(i,j,1)==m1&&A(i,j,2)==n1
           B{i,j}=temp;
       end
    end
    end
    
end 

lambda=B{1,1}(:,1);
C=cell(21,21);
 
lambda1=(380:1:800)';
for i=1:21
    for j=1:21
        C{i,j}=zeros(length(lambda1),2);
    end
 end
for i=1:21
    for j=1:21
       for k=1:length(lambda1) 
kk1(k)=interp1(lambda,B{i,j}(:,2),lambda1(k));
       end
       C{i,j}=kk1';
    end
end
D=cell(21,21);
Chromaticity;
for i=1:21
    for j=1:21
% color_plot(lambda1, C{i,j},i+j);
hold on;
XYZ=spectoxyz([lambda1, C{i,j}],'D65','1931_FULL',1);
sRGB=round(xyz2rgb(XYZ)*255);
x=XYZ(1)/sum(XYZ);
y=XYZ(2)/sum(XYZ);
scatter(x,y,10,'k','filled');
D{i,j}=sRGB;
    end
end
%  str600_1='E:\Al\ͼƬ\fig_res_600_2.png';
% h1=gcf;
% print(h1,str600_1,'-r600','-dpng')
Right=D;
figure;
myplane=zeros(1470,1470,3,'uint8');
set(gcf,'color','k');
for i=fliplr(1:1470)        
    for j=1:1470
        myplane(i,j,:)=D{ceil(j/70),ceil((1471-i)/70)};   
         k=35+(ceil(j/70)-1)*70;
        k1=35+(ceil(i/70)-1)*70;
        if (abs(j-k)>=34&&abs(j-k)<=35)||(abs(i-k1)>=34&&abs(i-k1)<=35)
        myplane(i,j,:)=[0 0 0];
        end
    end
end
imshow(myplane) ;

