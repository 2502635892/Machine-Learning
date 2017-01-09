clear all;
clc;
N1=500;
N2=500;
N3=500;
N=N1+N2+N3;
a=20;
b=18;
c=80;
d=18;
e=50;
f=18;
H=zeros(1,N1);
W=zeros(1,N1);
D1=zeros(1,N2);
D2=zeros(1,N2);
T1=zeros(1,N3);
T2=zeros(1,N3);

for i=1:1:N1
  H(i)=b*randn+a+6;
  W(i)=b*randn+a;
end

for i=1:1:N2
 D1(i)=d*randn+c;
 D2(i)=d*randn+c;
end

for i=1:1:N3
 T1(i)=f*randn+10;
 T2(i)=f*randn+90;
end


X=[H D1 T1;W D2 T2];

figure
for i=1:N
temp3=X(:,i);
plot(temp3(1),temp3(2),'ok');
hold on
end

W=zeros(N,N);
WW = zeros(N,N);

%ep=0;
for i=1:1:N
  WW(i,i) = 1;
   for j=i+1:1:N
         ep=(X(:,i)-X(:,j))'* (X(:,i)-X(:,j));
         delta=exp(-ep/2);
         W(i,j)=delta;
         W(j,i)=delta;
         WW(i,j)=delta;
         WW(j,i)=delta; 
   end
end

L = zeros(N,3);
L(1,1) = 1;
L(N1+1,2) = 1;
L(N1+N2+1,3) = 1;

D = diag(sum(W,2));
S=D^(-0.5)*W*D^(-0.5);
beta=0.99999;
OUT = ((eye(N)-beta*S))^(-1) * L;
FF = zeros(N,3);
for i=1:N
    if OUT(i,1) == max(OUT(i,:))
        FF(i,1) = 1;
    end
     if OUT(i,2) == max(OUT(i,:))
        FF(i,2) = 1;
     end
     if OUT(i,3) == max(OUT(i,:))
        FF(i,3) = 1;
    end
end

figure
for i=1:N
    temp3=X(:,i);
    if FF(i,1) ==1
      plot(temp3(1),temp3(2),'ro');
      hold on;
    end
    if FF(i,2) ==1
      plot(temp3(1),temp3(2),'go');
      hold on;
    end
    if FF(i,3) ==1
      plot(temp3(1),temp3(2),'bo');
      hold on;
    end
end
