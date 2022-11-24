clear
clc

motor = 15.6/1000 %% mass in kg
mass = 45.36/1000
finalMass = motor + mass

g = 9.81; %% Acceleration due to Earth's gravity

T = 6 %% Thrust in Newtons

A = 0.004 %% Frontal area in m^2

Cd = 0.75 %% Coefficient of drag

rho = 1.225 %% Density of Air

a(1) = 0 %% Initial Acceleration

v(1) = 0 %% Initial velocity

h(1) = 0 %% Initial height

t(1) = 0 %% Initial time

t_step= 0.01 %% size of time step with each step

i = 1 %% start of indexing variable


xValues = [0, 0.24, 0.28, 0.66, 0.72];
yValues = [0, 10, 2.5, 2.1, 0];

for j = 1:4
    m(j) = (yValues(j+1)- yValues(j)) / (xValues(j+ 1) - xValues(j));
    b(j) = yValues(j) - m(j) * xValues(j);
end

y = [];
i = 1;
y(1) = 0;

while h(i) >= 0 
   
    if t(i) >= 0 && t(i) < 0.24
        y(i + 1) = m(1) * t(i) + b(1);
    
    elseif t(i) >= 0.24 && t(i) < 0.28
        y(i + 1) = m(2) * t(i) + b(2);
       
    elseif t(i) >= 0.28 && t(i) < 0.66
        y(i + 1) = m(3) * t(i) + b(3);

    elseif t(i) >= 0.66 && t(i) < 0.72
        y(i + 1) = m(4) * t(i) + b(4);

    else
        y(i + 1) = 0 * t(i) + 0;
    end
        if finalMass * g >= y(i) && h(i) == 0 % if weight >= thrust
            a(i + 1) = 0;
         
        elseif v(i) >= 0
            a(i+1) = ((y(i)) - (finalMass*g) - (0.5 * rho * A * Cd * v(i)^2)) / finalMass;
            
        elseif v(i) < 0
            Cd = 1.75;
            A = 0.041;
            a(i+1) = ((y(i)) - (finalMass*g) + (0.5 * rho * A * Cd * v(i)^2)) / finalMass;
         
        end

        v(i+1) = a(i+1) * t_step + v(i); %Velocity

        h(i+1) = v(i+1) * t_step + h(i); %Height

        t(i+1) = t(i) + t_step; %time

        i = i + 1;
       
end
        



finalThrust = max(y)
finalAccel = max(a)
finalVel = max(v)
finalHeight = max(h)



j = max(a)
tiledlayout(2,2)

nexttile
plot(t,a,'k')
title('Time Vs. Acceleration')
ylabel('Acceleration [m/s^2]')
xlabel('Time [Sec]')


nexttile
plot(t,v,'k')
title('Time Vs. Velocity')
ylabel('Velocity [m/s]')
xlabel('Time [Sec]')

nexttile
plot(t,h,'k')
title('Time Vs. Height')
ylabel('Height [m]')
xlabel('Time [Sec]')