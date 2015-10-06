%% Math 566 (Fall 2014)
%% Network from AMO Figure 5.10(b), page 158



data = [1  1 2 3
	2  1 3 2
	3  2 3 4
	4  2 6 5
	5  3 4 1
	6  3 7 -4
	7  4 2 -1
	8  4 5 5 
	9  5 6 -2
	10 6 7 -4
	11 7 5 6	
	];

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

MC= max(abs(C));


	
function [D pred]= FIFOLC (A, MC)
	
	printf("endter FIFOLC\n");

	n = length(A)

	


	D = ones(1,n);
	D = D*inf;
	D(1)=0;

	pred =  zeros(1,n);

	

	twolist= zeros(2,n);

	twolist(1,1)=1;
	update = 0 ;

	iter = 0;

	while true
		
		update = 0 ;
		iter = iter + 1;
		

		

		if iter==n
			printf("MAX iter n== %d reached, stop\n", n);
			return;
		end

		if mod(iter,2) == 1	
			p = 1; 
			q = 2;
		else
			p = 2 ;
			q = 1 ;
		end
	
		de = 1; 
		en = 1;

		while twolist(p,de)!= 0

			i= twolist(p,de);		
					
			mylist= A(i,:);
			neighbor = find(mylist != inf);	    # include self, fine
			
			for j = neighbor 

				if D(j)> D(i)+ A(i, j)
					
					printf("update %d from %d\n",j,i);
		
					update =1;

					D(j)= D(i)+ A(i, j);
					pred(j)= i;

					if(D(j)< (-MC*n) )
						printf("MAX Length reached at node %d, stop\n",j);
						return;
					end
				
					


					if (length(find(twolist(q,:)==j))==0)				# if not enqueue
						twolist(q,en) = j ;	# enqueue
						en = en+ 1;
					end
				end
			end
			de = de + 1;  
		end		

		twolist(q,en) =0 ; 
		twolist(p,1) =0;




		if update == 0
			printf("no update, stop at iter %d\n", iter);
			return;
		end


		printf("================\niter %d\n",iter);

		printf("distance vector \n");
		disp(D);

		printf("pred vector \n");
		disp(pred);

		printf("queue for next iter, zero terminated \n");
		disp(twolist(q,:))

		printf("====================\n");
		
	end 

end 

[D pred]= FIFOLC (A, MC)


