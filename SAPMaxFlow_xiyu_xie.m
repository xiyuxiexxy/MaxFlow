%% Math 566 (Fall 2014)
%% Network from AMO Figure 7.21(a), page 243



data = [1  1 2 3
	2  1 3 3
	3  1 4 2
	4  2 5 4
	5  3 4 1
	6  3 6 2
	7  4 2 1	
	8  4 6 2
	9  5 4 1 
	10  5 6 1	
	];

T=data(:,2);
H=data(:,3);
C=data(:,4);

m=length(T);		 #edge
n=max(max(T), max(H));   #node



function adqueue = ADqueue (data)
	T=data(:,2);
	H=data(:,3);
	C=data(:,4);

	m=length(T);		 #edge
	n=max(max(T), max(H));   #node
	

	adqueue= zeros(n,n);
	

	i =1;
	j =1; 
	k =1;

	while k<=m
		adqueue(data(k,2), data(k,3))=data(k,4);
		k=k+1;	
       
	end
end

A= ADqueue(data);

r = A

function D = reverseDFS(A)
	n = length(A) ;
	D = ones(n,1);
	D = D*inf;

	D(n) =0;

	queue = find (A(:,n)>0);

	D(queue) =1 ;

	top =1 ;


	
	while top <n 
	
		j = queue(top)
		is = find (A(:,j)>0)

		
			
		for i = 1: length(is)
			if D(is(i))>D(j)+1;
				D(is(i))= D(j)+1;
			end

			if length(find (queue==is(i)))==0
				queue = [queue;is(i)];	
			end
		end	

		
	
		top = top+1;

		
	end

	
	
end


function j = findArch(R,D, i)

	printf("findArch for node %d\n", i);
	Js = find(R(i,:)>0)

	disp(D);
	for iter = 1: length(Js)
		j = Js(iter);
		if(D(i)== D(j)+1)
			return;
		end
	end
	j = -1;
end	
	

function  D = retreat (R, D, i)
	
	printf("function retreat for node %d\n", i);

	js =find( R(i,:)>0)
	
	
	D(i) = min(D(js))+1;
	printf("distance updated %d\n",D(i));
	disp(D);
end



function R = augument(R,D,pred,n)


	printf("function augument \n");

	disp(pred);
	j = n;
	i = pred(j);
	r = R(i, j);

	while (i!= 1)

		j = i;
		i = pred(j);
		r = min(r, R(i,j));	
	end


	printf("augmenting flowing %d\n", r);
	j = n ;
	i = pred(j)

	R(i,j) = R(i,j)-r;
	R(j,i) = R(j,i)+r;

	while (i!=1)

		j = i;
		i = pred(j);

		R(i,j) = R(i,j)-r;
		R(j,i) = R(j,i)+r;	

	end	

	disp(R)

end
function flow = maxFlow(A)

	R= A;
	n = length(A) ;
	D = reverseDFS(A)
	disp(D);

	i = 1;

	pred = zeros(n,1);


	iter = 1;
	while D(1)<n
			
		j = findArch(R,D,i)
		
		if(j ==-1)
			printf("retreating \n");
			D = retreat(R,D,i);
			

			if i != 1 		# 
				i = pred(i);
			end

		else
			pred(j)=i;
			
			if j== n
				printf("augmenting \n");
				R = augument(R, D, pred,n);
				i = 1;
				pred = zeros(n,1);
			

			else 
				
				printf("advance %d->%d\n",i,j);	
				i  = j;	
			end
		end	
		
	#	if iter ==27
	#		break;	
	#	end
		iter = iter+1;
	end	


	flow = zeros(n, n);

	for i = 1: n
		for j = i:n	
			if A(i,j) >= R(i,j)
				flow(i, j)= A(i,j)-R(i,j);
			else	
				flow(j,i) =R(i,j)-A(i,j);
			end
		end
	end	
	flow					
end


maxFlow(A);
