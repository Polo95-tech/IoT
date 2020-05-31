% Marco Döhring

%Einlesen der Testdaten mit relevanten Merkmalen
clear all;
%close all
load fisheriris
X = meas(:,3:4);

%Erzeugen des Diagramm mit Testdaten
figure;
plot(X(:,1),X(:,2),'ko','Markersize',5);
title 'Iris Daten'
xlabel 'Länge Blütenblatt in cm';
ylabel 'Breite Blütenblatt in cm';
%mit hold on weitere plot Befehle zu dem aktuellen Diagramm ein fügen
