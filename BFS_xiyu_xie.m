%% Math 566 (Fall 2014)
%% Network from AMO Figure 2.13, page 32

data=[1  1 2 25 30
      2  1 3 35 50
      3  2 4 15 40
      4  3 2 45 10
      5  4 3 15 30
      6  4 5 45 60
      7  5 3 25 20
      8  5 4 35 50 ];

% data=data(3:end,:)
T=data(:,2);
H=data(:,3);
m=length(T);		 #edge
n=max(max(T), max(H));   #node


edgelist= zeros(n,n);


i =1;
j =1; 
k =1;

while k<=m
         if T(k)>i
                i=i+1;
                j=1;
	end
               
	edgelist(i,j)=H(k);
	k=k+1;	
        j=j+1;
end

# disp(edgelist);


order= zeros(1,n);
pred =  zeros(1,n);
list = zeros(1,n);
next =1;



count =1; 

i =1;
j =1;

# init
order(1)=1;
pred(1)=0;

listtop = 1;
list(1)=1;

while count<n 	
#       disp(list);
       i = list(listtop);
       j=1;
       while edgelist(i,j)!=0
               child = edgelist(i,j);
               if order(child)==0	#unmark
                        count =count+1;
                        order(child) = count;
                        list(count) = child;
                        pred(child)  = i;
                end
                j =j+1;
        end
	listtop= listtop+1;	
end

disp(pred)
disp(order)



