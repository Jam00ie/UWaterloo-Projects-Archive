%% Constants
    m = 1.881;           % Mass of the car (kg)
    g = 9.81;            % Gravitational Acceleration (m/s^2)
    theta = pi/6;        % Angle of incline (rad)
    xA = 0.74;           % Initial position (m)
    xB = 0.15;           % Position right before bumper (m)
    xC = 0;              % Final position (m)
    vA = 0;              % Initial velocity (m/s)
    vC = 0;              % Final velocity (m/s)
    L = 0.164 / 2;       % Half length of one rubber band
    mu = 0.2;     % Plastic-on-metal kinetic coefficient of friction

%% Calculating rubber band k value

    weight = 0.2*g;      % Weight used for k value testing
    d = 0.065;           % Displacement of rubber band under said weight (kg)
    k = weight / d;

    % Rubber band positions and quantities
    rubberBandConfig = [
        0.14 1;
        0.12 2;
        0.1  3;
        0.08 6;
        0.06 6;
    ];
    
initialPosition = xA;  % Initial x position
initialVelocity = vA;     % Initial velocity
timeStep = 0.01;         % Time step for simulation
totalTime = 5;           % Total simulation time

motionMatrix = simulateCarMotion(rubberBandConfig, k, L, mu, theta, m, g, initialPosition, initialVelocity, timeStep, totalTime);

exportgraphics(gcf,'theoretical.pdf','ContentType','vector');

function motionMatrix = simulateCarMotion(rubberBandConfig, k, L, mu, theta, m, g, initialPosition, initialVelocity, timeStep, maxTime)
    % Constants
    g = 9.81;  % gravitational acceleration (m/s^2)

    % Initial conditions
    position = initialPosition;
    velocity = initialVelocity;
    acceleration = 0;  % Initialize acceleration

    % Arrays to store results
    times = 0:timeStep:maxTime;
    positions = zeros(size(times));
    velocities = zeros(size(times));
    accelerations = zeros(size(times));

    % Simulation loop
    for i = 1:length(times)
        % Calculate frictional force
        F_friction = frictionForce(mu, m, g, theta, velocity);

        % Calculate m * g * sin(theta)
        forceGravity = m * g * sin(theta);
    
        % Calculate total force from rubber bands
        totalForceRubberBands = totalRubberBandForce(position, rubberBandConfig, k, L);
    
        % Calculate acceleration using Newton's second law
        acceleration = (F_friction - forceGravity + totalForceRubberBands) / m;
    
        % Update position, velocity, and acceleration using Euler's method
        position = position + velocity * timeStep + 0.5 * acceleration * timeStep^2;
        velocity = velocity + acceleration * timeStep;

        % Store results in arrays
        positions(i) = position;
        velocities(i) = velocity;
        accelerations(i) = acceleration;
    
        % Check stopping condition
        if position <= 0 && velocity <= 0 && acceleration <= 0
            break;
        end
    end

    % Trim arrays to actual simulation duration
    times = times(1:i);
    positions = positions(1:i);
    velocities = velocities(1:i);
    accelerations = accelerations(1:i);

    % Create motion matrix
    motionMatrix = [times', positions', velocities', accelerations'];

    % Plot results
    figure;

    subplot(3,1,1);
    plot(times, positions, 'LineWidth', 2);
    xlabel('Time (s)');
    ylabel('Position (m)');
    title('Car Motion Simulation - Position');
    grid on;

    subplot(3,1,2);
    plot(times, velocities, 'LineWidth', 2);
    xlabel('Time (s)');
    ylabel('Velocity (m/s)');
    title('Car Motion Simulation - Velocity');
    grid on;

    subplot(3,1,3);
    plot(times, accelerations, 'LineWidth', 2);
    xlabel('Time (s)');
    ylabel('Acceleration (m/s^2)');
    title('Car Motion Simulation - Acceleration');
    grid on;
end

function frictionForce = frictionForce(mu, m, g, theta, velocity)
    % Calculate the normal force
    N = m * g * cos(theta);
    
    % Calculate the frictional force
    frictionForce = -mu * N * sign(velocity);  % Negative sign for opposite direction
end

function totalForce = totalRubberBandForce(carPosition, rubberBandConfig, k, L)
    totalForce = 0;
    
    for i = 1:size(rubberBandConfig, 1)
        bandPosition = rubberBandConfig(i, 1);
        numBands = rubberBandConfig(i, 2);
        
        delta_x = bandPosition - carPosition;
        
        % Check if the car has reached the rubber band
        if delta_x > 0
            % Calculate the force from the rubber band and multiply by the number of bands
            force = 2 * k * ((sqrt(L^2 + delta_x^2)) - L) * (delta_x / sqrt(L^2 + delta_x^2));
            totalForce = totalForce + numBands * force;
        end
    end
end