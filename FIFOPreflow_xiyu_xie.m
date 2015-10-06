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
	
		j = queue(top);
		is = find (A(:,j)>0);

		
			
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

	#printf("findArch for node %d\n", i);
	Js = find(R(i,:)>0);

	#disp(D);
	for iter = 1: length(Js)
		j = Js(iter);
		if(D(i)== D(j)+1)
			return;
		end
	end
	j = -1;
end	



function [R E List,sv, nsv] = push(R,E,List, i, j, sv, nsv)
	
	
	r = min(E(i),R(i, j));

	if r == R(i,j)
		sv = sv+ 1;
	else
		nsv = nsv+1;
	end
	
	printf("push %d ->%d by %d\n",i,j,r);
	
	#printf("old list\n");
	#disp(List);
	#printf("old E\n");
	#disp(E);

	E(j) = E(j)+r; 
	E(i) = E(i)-r;	

	R(i,j) = R(i,j)-r;
	R(j,i) = R(j,i)+r;
	
	

	if isempty(find(List==j))

		#printf("j not in list\n");

		if j!= 6 && j!= 1
			List = [List,j];
		end
	end	
	#printf("new list\n");
	#disp(List);
	#printf("new E\n");
	#disp(E);


end



function  D = retreat (R, D, i)
	
	#printf("function retreat for node %d\n", i);

	js =find( R(i,:)>0);
	
	
	D(i) = min(D(js))+1;
	printf("distance updated %d %d\n",i, D(i));
	disp(D);
end

function  [R E List] = start(R,E,List, i)
	
	List = [];
	
	n = length(E);
	
	for j = 1:n
		if R(i,j)> 0

			
			r = R(i, j)
	
			R(i,j) = R(i,j)-r;
			R(j,i) = R(j,i)+r;
	
			E(j) = E(j)+r; 
			E(i) = E(i)-r;
	
			if j!= 6 && j!= 1
				List = [List,j];
			end
		end
	end 	


end
function flow = preFlow(A)

	R= A;
	n = length(A) ;
	D = reverseDFS(A);
	#disp(D);


	
	E=  zeros(1,n);
	List = [];
	
	[R E List] = start(R,E,List, 1);

	D(1)=n;

	#printf("List\n");
	#disp(List);
	#printf("E\n");
	#disp(E);
	#pause
	
	sv = 0;
	nsv = 0;
	while !isempty(List)
		
		i = List(1);

		while E(i)> 0
		
			j = findArch(R,D,i);

			#printf("find %d ->%d\n",i,j);	

			if j!= -1 
				[R E List,sv, nsv] = push(R,E,List, i, j, sv, nsv);
			else
				#printf("node %d relabled\n",i);
				 D = retreat (R, D, i);
				 break;				
			end
			#pause
		end

		k= length(List);

		if k==0 && E(i) == 0
			#printf("list empty \n");
			List= [];
			break;
		end

		if E(i)>0;
			List = [List,i];
		end	

		k= length(List);
		#printf("after node %d\n",i);
		List=List(2:k);
		#printf("List\n");
		#disp(List);
		#printf("E\n");
		#disp(E);
		#pause
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
	disp(D)
	disp(E)

	printf("max flow vectors\n");
	flow		
	printf("max flow value %d\n",E(6));
	
	printf("# of saturating push %d; # of non staturating push %d\n",sv,nsv);
					
end


preFlow(A);
