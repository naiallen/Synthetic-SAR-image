h = str2double( get(handles.editHplat,'String') );
vplat = str2double( get(handles.editVplat,'String') );
alpha = str2double( get(handles.editAngIncid,'String') );
da = 50+((get(handles.sliderAzi,'Value'))*20);
de = str2double( get(handles.editLantenna,'String') );
freq = str2double( get(handles.editFcarrier,'String') )*(10^9);
bw = str2double( get(handles.editBW,'String') )*(10^6);
handles.par = parametros(h, alpha, da, de, freq, bw, vplat);

RCS(1) = ( get(handles.checkboxRCSmuitoalto,'Value') );
RCS(2) = ( get(handles.checkboxRSCalto,'Value') );
RCS(3) = ( get(handles.checkboxRSCmoderado,'Value') );
RCS(4) = ( get(handles.checkboxRSCbaixo,'Value') );
handles.RCS = RCS;

geraimagem

plotGeometry(handles)  
