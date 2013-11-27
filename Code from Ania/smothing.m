function y = smothing(for_plot1,n)
%f - function (numbers) for smothing
%Сглаживание делаю по Лагранжу(?). Смысл в том, что точки, 
%которые лежат ближе к "сглаживаемой" точке, обладают большим весеом:
%чем дальше от "сглаживаемой" точки, тем вес меньше. Рассматривала 2 точки
%слева, 2 справа, в итоге в сглаживании принимают участие 5 точек.

s = size(for_plot1);

for j = 1:n
    %for first 3
    weighted_summ = for_plot1(1) + (for_plot1(2))*0.85 + (for_plot1(3))*0.5+(for_plot1(4))*0.2;
    for_plot1_g(1) = weighted_summ/(1+0.85+0.5+0.2);

    weighted_summ = for_plot1(2) + (for_plot1(1) + for_plot1(3))*0.85 + (for_plot1(4))*0.5+(for_plot1(5))*0.2;
    for_plot1_g(2) = weighted_summ/(1+0.85*2+0.5+0.2);

    weighted_summ = for_plot1(3) + (for_plot1(2) + for_plot1(4))*0.85 + (for_plot1(1) + for_plot1(5))*0.5+(for_plot1(6))*0.2;
    for_plot1_g(3) = weighted_summ/(1+0.85*2+0.5*2+0.2);  

    for_plot1_g(1:3) = for_plot1(1:3);
    for i = 4:(s(2)-4)
        %1-ая - 0,85, 2-ая - 0,5, 3-я - 0,2
        weighted_summ = for_plot1(i) + (for_plot1(i-1) + for_plot1(i+1))*0.85 + (for_plot1(i-2) + for_plot1(i+2))*0.5+(for_plot1(i-3) + for_plot1(i+3))*0.2;
        for_plot1_g(i) = weighted_summ/(1+0.85*2+0.5*2+0.2*2);  
    end

    %for last 3
    weighted_summ = for_plot1(end) + (for_plot1(end-1))*0.85 + (for_plot1(end-2))*0.5+(for_plot1(end-3))*0.2;
    for_plot1_g(end) = weighted_summ/(1+0.85+0.5+0.2);

    weighted_summ = for_plot1(end-1) + (for_plot1(end-2) + for_plot1(end))*0.85 + (for_plot1(end-1-2))*0.5+(for_plot1(end-1-3))*0.2;
    for_plot1_g(end-1) = weighted_summ/(1+0.85*2+0.5+0.2);  

    weighted_summ = for_plot1(end-2) + (for_plot1(end-3) + for_plot1(end-1))*0.85 + (for_plot1(end-4) + for_plot1(end))*0.5+(for_plot1(end-5))*0.2;
    for_plot1_g(i) = weighted_summ/(1+0.85*2+0.5*2+0.2);  
    l(j,:) = for_plot1_g;
end

y = l(n,:);
end

