function run_ga(x, y, NIND, MAXGEN, NVAR, ELITIST, STOP_PERCENTAGE, PR_CROSS, PR_MUT, CROSSOVER, LOCALLOOP, ah1, ah2, ah3)
% usage: run_ga(x, y, 
%               NIND, MAXGEN, NVAR, 
%               ELITIST, STOP_PERCENTAGE, 
%               PR_CROSS, PR_MUT, CROSSOVER, 
%               ah1, ah2, ah3)
%
%
% x, y: coordinates of the cities
% NIND: number of individuals
% NVAR: Number of cities
% MAXGEN: maximal number of generations
% ELITIST: percentage of elite population
% STOP_PERCENTAGE: percentage of equal fitness (stop criterium)
% PR_CROSS: probability for crossover
% PR_MUT: probability for mutation
% CROSSOVER: the crossover operator
% calculate distance matrix between each pair of cities
% ah1, ah2, ah3: axes handles to visualise tsp
{NIND MAXGEN NVAR ELITIST STOP_PERCENTAGE PR_CROSS PR_MUT CROSSOVER LOCALLOOP}


        GGAP = 1 - ELITIST; % Generational gap
        mean_fits=zeros(1,MAXGEN+1); % Matrix voor bijhouden van gemiddelde waarden
        worst=zeros(1,MAXGEN+1); % Matrix voor bijhouden van slechtste waarde
        Dist=zeros(NVAR,NVAR); % Aantal parameters in chromosoom => Is wss aantal steden
        for i=1:size(x,1) % Bereken afstand tss alle steden
            for j=1:size(y,1)
                Dist(i,j)=sqrt((x(i)-x(j))^2+(y(i)-y(j))^2);
            end
        end
        % initialize population
        Chrom=zeros(NIND,NVAR); % Pop size x nbParam
        for row=1:NIND
            Chrom(row,:)=randperm(NVAR); 
        end
        gen=0;
        % number of individuals of equal fitness needed to stop
        stopN=ceil(STOP_PERCENTAGE*NIND); % Afronden naar Natuurlijk getal (naar boven)
        % evaluate initial population
        ObjV = tspfun(Chrom,Dist); % Bereken fitness
        best=zeros(1,MAXGEN); % Beste waarde? 
        % generational loop
        while gen<MAXGEN % Zolang max aantal stappen nie bereikt is
            sObjV=sort(ObjV); 
          	best(gen+1)=min(ObjV); % Zet beste huidige waarde in best
        	minimum=best(gen+1); 
            mean_fits(gen+1)=mean(ObjV);
            worst(gen+1)=max(ObjV);
            for t=1:size(ObjV,1)
                if (ObjV(t)==minimum) % Zoek het pad met de beste fitness 
                    break;
                end
            end
            visualizeTSP(x,y,Chrom(t,:), minimum, ah1, gen, best, mean_fits, worst, ah2, ObjV, NIND, ah3);

            if (sObjV(stopN)-sObjV(1) <= 1e-15) % Nde element scheelt minder als limietwaarde
                  break;
            end          
        	%assign fitness values to entire population
        	FitnV=ranking(ObjV);
        	%select individuals for breeding
        	
            % DEFAULT Stochastic Universal Sampling
            SelCh=select('sus', Chrom, FitnV, GGAP); 
            
            %Fitness proportional selection
            %SelCh = FitnessProportionalSelection(Chrom,FitnV,GGAP);
            
            % Tournament selection with replacement
            %SelCh = TournamentSelection(Chrom,FitnV,GGAP)
            
            
        	%recombine individuals (crossover)
            SelCh = recombin(CROSSOVER,SelCh,PR_CROSS);
            
            SelCh=mutateTSP('MyMutation',SelCh,PR_MUT);
            
            %evaluate offspring, call objective function
        	ObjVSel = tspfun(SelCh,Dist);
            %reinsert offspring into population
        	[Chrom ObjV]=reins(Chrom,SelCh,1,1,ObjV,ObjVSel);
            
            Chrom = tsp_ImprovePopulation(NIND, NVAR, Chrom,LOCALLOOP,Dist);
        	%increment generation counter
        	gen=gen+1;            
        end
end
