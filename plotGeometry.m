function plotGeometry(handles)  		

% handles.target.x 
% handles.target.y 
% handles.target.z 
% handles.target.r 
%% Plota a posição do sensor e do target===================================
r_max = handles.par.R_slt_far;    

grid( handles.axesGeom, 'on' )
axis(handles.axesGeom, [(-handles.par.Dsf/2)+1000 (handles.par.Dsf/2)+1000 -100 handles.par.R_grd_far+1000 0 handles.par.h+1])
view(handles.axesGeom, [30,30,30])
axis(handles.axesGeom, 'equal');
N = 2;

cla(handles.axesGeom);
%-Localização do sensor----------------
r_max = handles.par.R_slt_far;      %range maximo 
tep_slow_time = (handles.par.lambda/handles.par.da)*(r_max/handles.par.vplat); %tamanho do "pulso" em azimute
t_slow_time = -tep_slow_time/2:tep_slow_time/2;
vec_azimuth = t_slow_time*handles.par.vplat;          %cena coberta

hold(handles.axesGeom, 'on')
plot3(handles.axesGeom, vec_azimuth, 0 , handles.par.h, 'o', 'color',[0.8, 0.8, 0.8],  'LineWidth',1)

hold(handles.axesGeom, 'on')
plot3(handles.axesGeom, 0, 0 , handles.par.h, 'ok', 'LineWidth',3)

%-Slant Range Lines--------------------
%%--Range
x = zeros(1, N+1);
y = 0:handles.par.R_grd/N:handles.par.R_grd;
z = handles.par.h:-handles.par.h/N:0;
hold(handles.axesGeom, 'on')
plot3(handles.axesGeom, x, y, z, '-b', 'LineWidth',1)

%%-- Near Range
x = zeros(1, N+1);   
y = 0:handles.par.R_grd_near/N:handles.par.R_grd_near;
z = handles.par.h:-handles.par.h/N:0;
hold(handles.axesGeom, 'on')
plot3(handles.axesGeom, x, y, z, ':b', 'LineWidth',1)

m = handles.par.Ds/(2*N);
x = (0:-m:-handles.par.Ds/2);
y = 0:handles.par.R_grd/N:handles.par.R_grd;
z = handles.par.h:-handles.par.h/N:0;
hold(handles.axesGeom, 'on')
plot3(handles.axesGeom, x, y, z, ':r', 'LineWidth',1)

%%-- Far Range
x = zeros(1, N+1);
y = 0:handles.par.R_grd_far/N:handles.par.R_grd_far;
z = handles.par.h:-handles.par.h/N:0;
hold(handles.axesGeom, 'on')
plot3(handles.axesGeom, x, y, z, ':b', 'LineWidth',1)

m = handles.par.Ds/(2*N);
x = (0:m:handles.par.Ds/2);   
y = 0:handles.par.R_grd/N:handles.par.R_grd;
z = handles.par.h:-handles.par.h/N:0;
hold(handles.axesGeom, 'on')
plot3(handles.axesGeom, x, y, z, ':r', 'LineWidth',1)
%--------------------------------------

%-Swath Range--------------------------
x = zeros(1, N+1); 
y = handles.par.R_grd_near:handles.par.Sgrd/N:handles.par.R_grd_far;
z = zeros(1, N+1);
plot3(handles.axesGeom, x,y,z, ':b', 'LineWidth',1);

x = (-handles.par.Ds/2:handles.par.Ds/N:handles.par.Ds/2);
y(1, 1:N+1) = handles.par.R_grd;
z = zeros(1, N+1);
plot3(handles.axesGeom, x,y,z, ':r', 'LineWidth',1);

xhist = [];
yhist = [];
zhist = [];

%-Image Foot Print---------------------
x = [-handles.par.Dsn/2 handles.par.Dsn/2];
y = [handles.par.R_grd_near handles.par.R_grd_near];
z = zeros(1, 2);

xhist = [xhist x(1) x(end)];
yhist = [yhist y(1) y(end)];
zhist = [zhist z(1) z(end)];

x = [-handles.par.Dsf/2 handles.par.Dsf/2];
y = [handles.par.R_grd_far handles.par.R_grd_far];
z = zeros(1, 2);

xhist = [xhist x(1) x(end)];
yhist = [yhist y(1) y(end)];
zhist = [zhist z(1) z(end)];

x = [-handles.par.Dsn/2 -handles.par.Dsf/2];
y = [handles.par.R_grd_near handles.par.R_grd_far];
z = zeros(1, 2);

xhist = [xhist x(1) x(end)];
yhist = [yhist y(1) y(end)];
zhist = [zhist z(1) z(end)];

x = [handles.par.Dsn/2 handles.par.Dsf/2];
y = [handles.par.R_grd_near handles.par.R_grd_far];
z = zeros(1, 2);

xhist = [xhist x(1) x(end)];
yhist = [yhist y(1) y(end)];
zhist = [zhist z(1) z(end)];

xhistant = [xhist(1) xhist(2) xhist(4) xhist(6) xhist(1)];
yhistant = [yhist(1) yhist(2) yhist(3) yhist(3) yhist(1)];
zhistant = zhist(1:5);

h2 = fill3(handles.axesGeom, xhistant,yhistant,zhistant, 'c');
h2.FaceColor = [0.8 0.8 0.8];
h2.EdgeColor = [0.2 0.2 0.2];
%--------------------------------------

%--Target plot-------------------------
% cla(handles.axesGeom);
if sum(handles.RCS)>0
    cindex = handles.classes.index;
    cposition = handles.classes.position;
    stepx = round((cposition(1,2) - cposition(1,1) )/5);
    stepy = round((cposition(1,4) - cposition(1,3) )/10);
    
    for cl = 1:size(cposition,1)
        maximo =  max(max(abs(handles.imraw(cposition(cl, 1):cposition(cl, 2), cposition(cl, 3):cposition(cl, 4) ))) );
        for ii = cposition(cl, 1):stepx:cposition(cl, 2)
            for jj = cposition(cl, 3):stepy:cposition(cl, 4)
                hold on
                if (cindex(cl) == 1)
                    color = [abs(handles.imraw(ii, jj))/maximo, abs(handles.imraw(ii, jj))/maximo, abs(handles.imraw(ii, jj))/maximo];
                    plot3(handles.axesGeom, (ii*handles.par.pxa)-handles.par.Ds/2, (jj*handles.par.pxr)+handles.par.R_grd_near, 0, '.','color',color, 'LineWidth',1)
                elseif (cindex(cl) == 2)
                    color = [0, abs(handles.imraw(ii, jj))/maximo, 0];
                    plot3(handles.axesGeom, (ii*handles.par.pxa)-handles.par.Ds/2, (jj*handles.par.pxr)+handles.par.R_grd_near, 0, '.','color',color, 'LineWidth',1)
                elseif (cindex(cl) == 3)
                    color = [abs(handles.imraw(ii, jj))/maximo, abs(handles.imraw(ii, jj))/maximo, 0];
                    plot3(handles.axesGeom, (ii*handles.par.pxa)-handles.par.Ds/2, (jj*handles.par.pxr)+handles.par.R_grd_near, 0, '.','color',color, 'LineWidth',1)
                elseif (cindex(cl) == 4)
                    color = [0, 0, abs(handles.imraw(ii, jj))/maximo];
                    plot3(handles.axesGeom, (ii*handles.par.pxa)-handles.par.Ds/2, (jj*handles.par.pxr)+handles.par.R_grd_near, 0, '.','color',color, 'LineWidth',1)
                end
            end
        end
    end
end
%==========================================================================
end