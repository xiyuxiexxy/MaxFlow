%% Math 566 (Fall 2014)
%% Network from AMO Figure 2.13, page 32



data = [1  1 2 2 
	2  1 3 8
	3  2 3 5
	4  2 4 3
	5  3 2 6
	6  3 5 0
	7  4 3 1
	8  4 5 7
	9  4 6 6
	10 5 4 4 
	11 6 5 2];

T=data(:,2);
H=data(:,3);
C=data(:,4);

m=length(T);		 #edge
n=max(max(T), max(H));   #node



function adlist = ADLIST (data)
	T=data(:,2);
	H=data(:,3);
	C=data(:,4);

	m=length(T);		 #edge
	n=max(max(T), max(H));   #node
	

	adlist= zeros(n,n);
	for i = 1:n
		for j =1:n 
			if i==j	
				adlist(i, j)=0;
			else
				adlist(i, j)=inf;
			end
		end
	end


	i =1;
	j =1; 
	k =1;

	while k<=m
		adlist(data(k,2), data(k,3))=data(k,4);
		k=k+1;	
       
	end
end

A= ADLIST(data)



	
function [D pred]= Dijkstra (adlist)
	
	n = length(adlist)


	D = zeros(1,n);
	for i = 1:n
		D(i)=inf;
	end

	pred =  zeros(1,n);

	s= zeros(1,n);
	s_bar = ones(1,n);

	D(1)=0;
	top=1;
	s(1)=1;


	printf("init value\n");

D
pred
s
s_bar

iter= 1

while iter <= n

		printf("update node : ")
	
		i =find( D==min(D.*s_bar))(1)	
	
		s(top) =i;

		s_bar(i)=inf;
	
		for j = 1:n
			if D(j)> D(i)+ adlist(i, j)
				D(j)= D(i)+ adlist(i, j);
				pred(j)= i;
			end
		end
		  	

	
		iter
		D
		s
		s_bar

		top = top+1;
		iter = iter+1 ;
	
	end
	
end


[D pred] = Dijkstra (A)




