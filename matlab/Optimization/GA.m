function [finalCost,x1,x2] = GA
clear all
close all
clc

% GA algorithm for minimization of egg crate function

% Initialize GA parameters

numVars = 2; % number of variables
nGen = 50; % num of generations
N = 1000; % population of individuals (even)
res = 0.01; % Discretization resolution
lbound = -5; % Upper and lower bounds of variables
ubound = 5;
n = ceil(log((ubound-lbound)/res + 1)/log(2)); % Min number of bits
nTot = n*numVars; % Total bits in concatenated chromosome
nElite = 600; % Number of 'elite' individuals that are transferred to next generation (even)
Pmut = 0.15; % Probability of a mutation occuring

% Create the first generation
gen1 = round(rand(N,n*numVars));

% Sort the first gen based on cost
cost = zeros(N,1);
for i = 1:N
    x1 = lbound + res*greycode2cont(gen1(i,1:n));
    x2 = lbound + res*greycode2cont(gen1(i,n+1:end));    
    cost(i) = eggCrate([x1 x2]);
end
[cost,ind] = sort(cost);
gen1 = gen1(ind,:);
plotPop = zeros(N,5);
x1 = zeros(N,1);
x2 = zeros(N,1);

% Start loop for evolution process
curGen = gen1;
for g = 1:(nGen)
    
    % Calculate number of matings needed to replace failures
    nMatings = 0.5*(N-nElite);
    % Weight variables based on cost
    fitness = 1./cost;
    prob = cumsum(flipud(fitness/sum(fitness)))';
%     prob = cumsum(flipud((-cost(end:-1:1))/sum(-cost)));
%     fitness = flipud(ones(N,1) - cost./sum(cost));
%     fitness = flipud((1:N')/sum(1:N));
%     prob = cumsum(fitness);
    r1 = rand(nElite,1); % Create random numbers to use to choose parents
    r2 = rand(nElite,1);
    
    % For each random number, the parent will be the first number in the
    parent1 = zeros(nMatings,1);
    parent2 = parent1;
    for i = 1:nMatings
        f1 = find(prob >= r1(i));
        parent1(i) = f1(1);
        f2 = find(prob >= r2(i));
        parent2(i) = f2(1);
    end
    
    % Now that parents are selected, do a single point crossover to mate
    crossPt = floor((numVars*n-1)*rand(1)+1);
    ch = (1:2:2*nMatings-1)';
    curGen(nElite+ch,:) = [curGen(parent1,1:crossPt) curGen(parent2,crossPt+1:end)];
    curGen(nElite+ch+1,:) = [curGen(parent2,1:crossPt) curGen(parent1,crossPt+1:end)];
    
    % Once mating is done, introduce mutation
    
    % Find probability of each bit changing that results in the overall
    % probability of mutation equation to that given
    Pbit = 1 - (1 - Pmut)^(1/(nTot));
    % Flip every bit with this probability
    flipRand = rand(N,nTot);
    curGen(flipRand < Pbit) = ~curGen(flipRand < Pbit);
    
    % Evaluate cost and re-sort curGen
    for i = 1:N
        x1(i) = lbound + res*greycode2cont(curGen(i,1:n));
        x2(i) = lbound + res*greycode2cont(curGen(i,n+1:end));    
        cost(i) = eggCrate([x1(i) x2(i)]);
    end
    [cost,ind] = sort(cost);
    curGen = curGen(ind,:);    
    
    % Capture every 10th generation for plotting
    if mod(g,10) == 0
       plotPop(:,g/5-1) = x1;
       plotPop(:,g/5) = x2;
    end
end

% Evaluate cost

x1 = lbound + res*greycode2cont(curGen(1,1:n));
x2 = lbound + res*greycode2cont(curGen(1,n+1:end));

finalCost = cost(1);

% Plot results
ezcontour('x1^2+x2^2+25*(sin(x1)^2+sin(x2)^2)',[-5 5 -5 5])
hold on
fill([3,-2,-5,-5],[-5,5,5,-5],'g')
plot(plotPop(:,1),plotPop(:,2),'ro')
xlabel('x1')
ylabel('x2')

figure
ezcontour('x1^2+x2^2+25*(sin(x1)^2+sin(x2)^2)',[-5 5 -5 5])
hold on
fill([3,-2,-5,-5],[-5,5,5,-5],'g')
plot(plotPop(:,3),plotPop(:,4),'bo')
xlabel('x1')
ylabel('x2')

figure
ezcontour('x1^2+x2^2+25*(sin(x1)^2+sin(x2)^2)',[-5 5 -5 5])
hold on
fill([3,-2,-5,-5],[-5,5,5,-5],'g')
plot(plotPop(:,5),plotPop(:,6),'yo')
xlabel('x1')
ylabel('x2')

figure
ezcontour('x1^2+x2^2+25*(sin(x1)^2+sin(x2)^2)',[-5 5 -5 5])
hold on
fill([3,-2,-5,-5],[-5,5,5,-5],'g')
plot(plotPop(:,7),plotPop(:,8),'co')
xlabel('x1')
ylabel('x2')

figure
ezcontour('x1^2+x2^2+25*(sin(x1)^2+sin(x2)^2)',[-5 5 -5 5])
hold on
fill([3,-2,-5,-5],[-5,5,5,-5],'g')
plot(plotPop(:,9),plotPop(:,10),'mo')
xlabel('x1')
ylabel('x2')

end








