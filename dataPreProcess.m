function dataPreProcess(filename)
AA = load(filename);
idx = [31];
while find(idx == 31)
    idx = find(AA(1,:) == 0);
    AA(1,:) = [];
end
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

length = size(AA,1);
newAA = AA(1,:);
for i = 2:length
    if AA(i,15) == AA(i-1,15)
        ;
    else
        newAA = [newAA;AA(i,:)];
    end
end
save('processed_nitro.mat','newAA');
load 'processed_union_jun1.mat'

figure(1)
id = 1:size(newAA,1);
plot(id,newAA(:,3), 'r');hold on;
plot(id, newAA(:,31), 'g');grid on;
figure(2)
id = 1:size(AA,1);
plot(id, AA(:,3), 'r');hold on;
plot(id, AA(:,31), 'g');grid on;
a = 1;

% plot position values
figure(3)
subplot(3,1,1)
plot(AA(:,31),AA(:,34),'g');hold on;
plot(AA(:,3),AA(:,15),'r');grid on;
xlabel('time [s]');ylabel('X pos [m]');
legend('GPS pos x','NAV pos x');
subplot(3,1,2)
plot(AA(:,31),AA(:,35),'g');hold on;
plot(AA(:,3),AA(:,16),'r');grid on;
xlabel('time [s]');ylabel('Y pos [m]');
legend('GPS pos y','NAV pos y');
subplot(3,1,3)
plot(AA(:,31),AA(:,36),'g');hold on;
plot(AA(:,3),AA(:,17),'r');grid on;
xlabel('time [s]');ylabel('Z pos [m]');
legend('GPS pos z','NAV pos z');

figure(4)
subplot(3,1,1)
plot(newAA(:,31),newAA(:,34),'g');hold on;
plot(newAA(:,3),newAA(:,15),'r');grid on;
xlabel('time [s]');ylabel('X pos [m]');
legend('GPS pos x','NAV pos x');
subplot(3,1,2)
plot(newAA(:,31),newAA(:,35),'g');hold on;
plot(newAA(:,3),newAA(:,16),'r');grid on;
xlabel('time [s]');ylabel('Y pos [m]');
legend('GPS pos y','NAV pos y');
subplot(3,1,3)
plot(newAA(:,31),newAA(:,36),'g');hold on;
plot(newAA(:,3),newAA(:,17),'r');grid on;
xlabel('time [s]');ylabel('Z pos [m]');
legend('GPS pos z','NAV pos z');
end