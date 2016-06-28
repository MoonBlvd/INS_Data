function plotINSdata(filename)

AA = load(filename);

AA(1:10,:) = [];
temperature = AA(:,2)/100;
time = (AA(:,3)-AA(1,3))/1000; % transfer to seconds.
timeGPS = (AA(:,31)-AA(1,31))/1000;
angularRates = AA(:,4:6)/100; % deg/s
accel = AA(:,7:9)/100; % transfer to m/s^2
yaw = AA(:,10)/100; pitch = AA(:,11)/100; roll = AA(:,12)/100; % transfer to degree
% yawIdx = find(yaw < 0);
yaw(yaw < 0) = yaw(yaw < 0) + 360;
navPosX = (AA(:,15)-AA(1,15))/100; navPosY = (AA(:,16)-AA(1,16))/100; % transfer to meter
navPosZ = (AA(:,17)-AA(1,17))/100; % transfer to meters.
navVel = AA(:,18:20)/100; % transfer to m/s.
gpsPosX = (AA(:,34)-AA(1,34))/100; gpsPosY = (AA(:,35)-AA(1,35))/100; % transfer to meter
gpsPosZ = (AA(:,36)-AA(1,36))/100; % transfer to meters.
gpsVel = AA(:,37:39)/100; % transfer to m/s.

AA(:,2) = AA(:,2)/100; % transfer to celcius degree
AA(:,3) = (AA(:,3)-AA(1,3))/1000;
AA(:,31) = (AA(:,31)-AA(1,31))/1000;
AA(:,4:6) = AA(:,4:6)/100;
AA(:,7:9) = AA(:,7:9)/100; 
AA(:,10:12) = AA(:,10:12)/100; % transfer to degree/sec
AA(:,15) = (AA(:,15)-AA(1,15))/100; AA(:,16) = (AA(:,16)-AA(1,16))/100; % transfer to meter
AA(:,17) = (AA(:,17)-AA(1,17))/100; % transfer to meters.
AA(:,18:20) = AA(:,18:20)/100; % transfer to m/sTime (ms).
AA(:,23:26) = AA(:,23:26)/100; % transfer to , and m/s
AA(:,34) = (AA(:,34)-AA(1,34))/100; AA(:,35) = (AA(:,35)-AA(1,35))/100; % transfer to meter
AA(:,36)= (AA(:,36)-AA(1,36))/100; % transfer to meters.
AA(:,37:39) = AA(:,37:39)/100; % transfer to m/s.


% plot position values
figure(1)
subplot(3,1,1)
plot(time,gpsPosX,'g');hold on;
plot(time,navPosX,'r');grid on;
xlabel('time [s]');ylabel('X pos [m]');
legend('GPS pos x','NAV pos x');
subplot(3,1,2)
plot(time,gpsPosY,'g');hold on;
plot(time,navPosY,'r');grid on;
xlabel('time [s]');ylabel('Y pos [m]');
legend('GPS pos y','NAV pos y');
subplot(3,1,3)
plot(time,gpsPosZ,'g');hold on;
plot(time,navPosZ,'r');grid on;
xlabel('time [s]');ylabel('Z pos [m]');
legend('GPS pos z','NAV pos z');

% plot Euler angles
figure(2)
subplot(3,1,1);
plot(time,yaw);grid on;
xlabel('time [s]');ylabel('Yaw [deg]');
subplot(3,1,2);
plot(time,pitch);grid on;
xlabel('time [s]');ylabel('Pitch [deg]');
subplot(3,1,3);
plot(time,roll);grid on;
xlabel('time [s]');ylabel('Roll [deg]');

% plot velocities
figure(3)
subplot(3,1,1)
plot(time,gpsVel(:,1),'g');hold on;
plot(time,navVel(:,1),'r');grid on;
xlabel('time [s]');ylabel('X vel [m/s]');
legend('GPS vel x','NAV vel x');
subplot(3,1,2)
plot(time,gpsVel(:,2),'g');hold on;
plot(time,navVel(:,2),'r');grid on;
xlabel('time [s]');ylabel('Y vel [m/s]');
legend('GPS vel y','NAV vel y');
subplot(3,1,3)
plot(time,gpsVel(:,3),'g');hold on;
plot(time,navVel(:,3),'r');grid on;
xlabel('time [s]');ylabel('Z vel [m/s]');
legend('GPS vel z','NAV vel z');

%plot angular rates
figure(4)
subplot(3,1,1)
plot(time,angularRates(:,1));grid on;
xlabel('time [s]');ylabel('Yaw rate [deg/s]');
subplot(3,1,2)
plot(time,angularRates(:,2));grid on;
xlabel('time [s]');ylabel('Pitch rate [deg/s]');
subplot(3,1,3)
plot(time,angularRates(:,3));grid on;
xlabel('time [s]');ylabel('Roll rate [deg/s]');

% plot acclerations
figure(5)
subplot(3,1,1);
plot(time,accel(:,1));grid on;
xlabel('time [s]');ylabel('X accel [m/s^2]');
subplot(3,1,2);
plot(time,accel(:,2));grid on;
xlabel('time [s]');ylabel('Y accel [m/s^2]');
subplot(3,1,3);
plot(time,accel(:,3));grid on;
xlabel('time [s]');ylabel('Z accel [m/s^2]');

% plot temperature
figure(6)
plot(time, temperature,'k');grid on;
xlabel('time [s]'); ylabel('C deg');

% plot timestamps wrt # of rows
figure(7)
plot([1:length(time)],AA(:,31),'g');hold on;
plot([1:length(time)],time,'r');grid on;
xlabel('# of data stream');ylabel('time [s]');
legend('GPS time','NAV time');

% plot the trajectory
figure(8)
plot(gpsPosX,gpsPosY,'g');hold on;
plot(navPosX,navPosY,'r');hold on;
plot(gpsPosX(1),gpsPosY(1),'bp','MarkerSize',10,'MarkerFace','b');hold on;
plot(gpsPosX(end),gpsPosY(end),'kp','MarkerSize',10,'MarkerFace','k');grid on;
xlabel('x [m]');ylabel('y [m]');
% title('NAV position vs GPS position');
legend('GPS','NAV','Start','End');
for i = 1:size(AA,1)
    %calculate the position and velocity discrepancies
    posErr = abs(AA(i,15:17)-AA(i,34:36));
    velErr = abs(AA(i,18:20)-AA(i,47:39));
    
    %
end

% subplot(2,2,1);
% plot(navPosX,navPosY,'r');
% hold on;
% plot(gpsPosX,gpsPosY,'g');
% grid on;
% xlabel('x [deg]');ylabel('y [deg]');
% title('NAV position vs GPS position');
% legend('NAV','GPS');
% 
% subplot(2,2,2);
% plot(time,navPosZ,'r');
% hold on;
% plot(time,gpsPosZ,'g');
% grid on;
% xlabel('time [s]');ylabel('z [m]');
% title('NAV altitude vs GPS altitude');
% legend('NAV','GPS');
% 
% subplot(2,2,3);
% plot(time,navVel(:,1),'r');
% hold on;
% plot(time,gpsVel(:,1),'g');
% grid on;
% xlabel('time [s]');ylabel('x speed [m/s]');
% title('NAV velocity vs GPS velocity');
% legend('NAV','GPS');
% 
% subplot(2,2,4);
% plot(time, yawRate);
% grid on;
% xlabel('time [s]');ylabel('yaw rate [deg/s]');
% title('Yaw rate of the car');

end
