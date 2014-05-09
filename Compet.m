function varargout = Compet(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Compet_OpeningFcn, ...
                   'gui_OutputFcn',  @Compet_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end

function Compet_OpeningFcn(hObject, eventdata, handles, varargin)
set(handles.txtCapas,'Enable','off');
set(handles.txtNNeuronas,'Enable','off');
set(handles.txtNeuronas,'Enable','off');
set(handles.lstboxEntrenamiento,'Enable','off');
set(handles.btnNewff,'Enable','off');
set(handles.btnAgregar,'Enable','off'); 
global numeroCapas; 
global vectorCapas;
global funcion;
global fe;
numeroCapas=1;
handles.output = hObject;
guidata(hObject, handles);
axes(handles.imagen) 
handles.imagen=imread('unl_logo.bmp'); 
imagesc(handles.imagen) 
axis off



function varargout = Compet_OutputFcn(hObject, eventdata, handles) 

varargout{1} = handles.output;

function btnCompet_Callback(hObject, eventdata, handles)
    std_dev = 0.05; % desviacion estandar de cada cluster
    p = str2num(handles.txtPuntos); % numero de puntos/ cluster
    % recibe el numero de neuronas
    numero_neuronas=str2num(handles.txtNumeroNeuronas);
    cl =  numero_neuronas; % numero de clusters clusters
    z = [0 1; 0 1]; % limites de los clusters
    S = nngenc(z, cl, p, std_dev);
    A=handles.txtEntradaUno;% recibe el vector 1
    B=handles.txtEntradaDos;% recibe el vector 2
    valor= [A num2str(B)];%concatena A con B en una sola matriz
    valor1=str2num(valor);% lo convierte en entero
    set(handles.text5,'String',num2str(valor1));% pone la matriz en text5
    
    numero_neuronas=str2num(handles.txtNumeroNeuronas);
    % iguala las neuronas al mismo numero de clusters
    set(handles.txtClusters,'String',handles.txtNumeroNeuronas);
    %si es 1 pone valores por defecto si no a eleccion del ususario
    if handles.rbtnMinMax==1
       m=[0 1;0 1];
    else
         m=str2num(handles.m1)
    end 
    %crea la nueva rede competitiva
    % recibe como parametro 1 los valores maximos y minimos
    % el numero de neuronas
    netct=newc(m,numero_neuronas,.1);
    %grafica de los valores iniciales
    axes(handles.axes1);
    plot (S(1,:), S(2,:),'+r');
    %prueba asignandoles el peso con el valor de uno
    w = netct.IW{1};
    %grafica de nuevo
    axes(handles.axes1);
    plot (S(1,:), S(2,:),'+r');
    axes(handles.axes1);
    hold on;
    circles = plot(w(:,1),w(:,2),'ob');
    hold on; 
    %añade los vectores de entrada
    x = valor1;
    %grafica de nuevo
    plot (x(1,:), x(2,:), '+b')
    %numero de veces que se va entrenar
    netct.trainParam.epochs=str2num(handles.txtIteraciones);
    netct=train(netct,S);
    w = netct.IW{1};
    delete(circles);
    axes(handles.axes2);
    plot (S(1,:), S(2,:),'+r');
    hold on;
    plot (w(:,1), w(:,2), 'ob');
    %simulacion de la red
    y = sim(netct, x);
    result=vec2ind(y);
    hold on; 
    plot (x(1,:), x(2,:), '+b')
    %muestra en las cajas de texto la neurona que gano
    set(handles.lblSalida,'String',num2str(y));
    set(handles.lblNeuronaGanadora,'String',num2str(result));



function txtEntradaUno_Callback(hObject, eventdata, handles)

Val=get(hObject,'String');
n1='[';
n = [n1 num2str(Val)];
n2=';';
valor= [n num2str(n2)];
handles.txtEntradaUno=valor;
disp(valor);
guidata(hObject,handles);

function txtEntradaUno_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function txtEntradaDos_Callback(hObject, eventdata, handles)
Val=get(hObject,'String');
n1=']';
valor= [Val num2str(n1)];
handles.txtEntradaDos=valor;
guidata(hObject,handles);

function txtEntradaDos_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function txtNumeroNeuronas_Callback(hObject, eventdata, handles)

Val=get(hObject,'String');
handles.txtNumeroNeuronas=Val;
guidata(hObject,handles);

function txtNumeroNeuronas_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function salidas_Callback(hObject, eventdata, handles)

function salidas_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function txtPuntos_Callback(hObject, eventdata, handles)

Val=get(hObject,'String');

handles.txtPuntos=Val;
guidata(hObject,handles)

function txtPuntos_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit6_Callback(hObject, eventdata, handles)

function edit6_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function txtClusters_Callback(hObject, eventdata, handles)

function txtClusters_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function m1_Callback(hObject, eventdata, handles)
Val=get(hObject,'String');
n1='[';
valor= [n1 num2str(Val)];
v=']';
v1=[valor num2str(v)];
handles.m1=v1;
display(v1);
guidata(hObject,handles);

function m1_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function m3_Callback(hObject, eventdata, handles)

function m3_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function m4_Callback(hObject, eventdata, handles)

function m4_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function m2_Callback(hObject, eventdata, handles)

function m2_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function rbtnMinMax_Callback(hObject, eventdata, handles)
Val=get(hObject,'value');
handles.rbtnMinMax=Val;
display(Val);
if Val==1
    set(handles.m1,'Enable','off');
else
     set(handles.m1,'Enable','on');
end 

guidata(hObject,handles);


% --- Executes on button press in rbtnNewc.
function rbtnNewc_Callback(hObject, eventdata, handles)

function rbtnNewff_Callback(hObject, eventdata, handles)


function txtCapas_Callback(hObject, eventdata, handles)
val=get(hObject,'String');
handles.txtCapas=val;
guidata(hObject,handles);

function txtCapas_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in lstboxEntrenamiento.
function lstboxEntrenamiento_Callback(hObject, eventdata, handles)
global fe; 
pos=get(hObject,'value');
if pos==1
    fe='traingb';
else
    if pos==2
       fe='traingdm'; 
       else
    if pos==3
       fe='traingdx'; 
    else
        if pos==4
            fe='trainrp';
        else
            if pos==5
            fe='train';
            else
                if pos==6
            fe='trainsgp';
                end                
            end            
        end
    end
    end
    end

 display(fe);
guidata(hObject,handles);



function lstboxEntrenamiento_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function btnNewff_Callback(hObject, eventdata, handles)
    %número de capas
    global vectorCapas;
    %función compet
    global funcion;
    %función de entrenamiento
    global fe;

    %1 cuando la función toma valores por defecto 0,1
    if handles.rbtnMinMax==1
       m=[0 1;0 1];
    else
         m=str2num(handles.m1);
    end 
    %vectores de entrada
    A=handles.txtEntradaUno;
    B=handles.txtEntradaDos;
    %crea la matriz
    valor= [A num2str(B)];
    %conversión a numero
    valor1=str2num(valor);
    %se crea la red newff parámetros
    %número máximo y mínimo, número de neuronas por capa, función de
    %transferencia compet y función de entrenamiento
    net=newff(m,str2num(vectorCapas), {'compet','compet'},fe); 
    %set(handles.txtNumeroNeuronas,'String');
    %p recibe la ntriz de entrada
     P = valor1;
     %salidas deseadas
     T = [0 1 1 0];
    %entrenamiento visto en pantalla
    net.trainParam.show = 50; 
    %Tasa de aprendizaje
    net.trainParam.lr = 0.05; 
    %número de iteraciones para el entrenamiento
    net.trainParam.epochs =str2num(handles.txtIteraciones); 
    %Objetivo de rendimiento
    net.trainParam.goal = 1e-3; 
    %gráfica del aprendizaje
    axes(handles.axes2);
    plot (P(1,:), P(2,:), '+b')
    hold on;
    % siguiente entrenamiento la función 
    %recibe de parámetro la red las entradas, y las salidas
    net1 = train(net, P, T);
    %nuevos pesos
    w = net1.IW{1,1};
    %gráfica final
    axes(handles.axes2);
    plot (w(:,1), w(:,2), 'or');


function pushbutton3_Callback(hObject, eventdata, handles)


function txtNeuronas_Callback(hObject, eventdata, handles)
Val=get(hObject,'String');
handles.txtNeuronas=Val;
guidata(hObject,handles);

function txtNeuronas_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in btnAgregar.
function btnAgregar_Callback(hObject, eventdata, handles)
global numeroCapas;
global funcion;
global vectorCapas;
numCapas=str2num(handles.txtCapas);
inicio='[';
cs='''';
coma=',';
 f='compet';
if numeroCapas<=numCapas
    %set(handles.txtCapas,'Enable','on');
    if numeroCapas==1
        nneuronas=[inicio num2str(handles.txtNNeuronas)];  
        f1=[ cs num2str(f)]; 
        funcion= [ f1 num2str(cs)]; 
    else
        a=funcion;
        f2= [ a num2str(coma)]; 
        f3= [ f2 num2str(cs)];
        f4= [ f3 num2str(f)];
        funcion=[ f4 num2str(cs)];
        nneuronas=vectorCapas;        
        espacio=',';
        neurona=[ nneuronas num2str(espacio)];  
        nneuronas= [neurona num2str(handles.txtNNeuronas)];
       
    end
    vectorCapas=nneuronas;  
    %handles.txtNNeuronas=vectorCapas;
  
    
    if numeroCapas==numCapas
        cerrar=']';
     nneuronas=vectorCapas;
    
     vectorCapas=[ nneuronas num2str(cerrar)];     
      set(handles.txtNeuronas,'String', vectorCapas);
    end
    set(handles.txtNeuronas,'String', vectorCapas);
    %set(handles.txtNNeuronas,'String', '');
    display(funcion);
    numeroCapas=numeroCapas+1;
else
    display(vectorCapas);
    set(handles.txtNNeuronas,'Enable','off');
end

function txtNNeuronas_Callback(hObject, eventdata, handles)
Val=get(hObject,'String');
handles.txtNNeuronas=Val;
guidata(hObject,handles);

function txtNNeuronas_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtNNeuronas (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
global fe; 
val=get(hObject,'String');
 pos=get(hObject,'value');
 ft=val(pos);
 fe=(val{1,1});
 display(v);



function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function gpanel_CreateFcn(hObject, eventdata, handles)



% --- Executes when selected object is changed in gpanel.
function gpanel_SelectionChangeFcn(hObject, eventdata, handles)
chk=get(handles.gpanel,'SelectedObject');
%se ejecuta al pulsar el botn btnCalcular
display(get(handles.gpanel,'SelectedObject'));
    switch get(chk,'Tag')
        
       case 'rbtnNewc', 
           set(handles.txtCapas,'Enable','off');
           set(handles.txtNNeuronas,'Enable','off');
           set(handles.txtNeuronas,'Enable','off');
            set(handles.lstboxEntrenamiento,'Enable','off');
            set(handles.btnNewff,'Enable','off');
             set(handles.btnAgregar,'Enable','off'); 
            set(handles.txtIteraciones,'Enable','on');
            set(handles.txtNumeroNeuronas,'Enable','on');
            set(handles.btnCompet,'Enable','on');
            set(handles.txtPuntos,'Enable','on');
     
       case 'rbtnNewff', 
           set(handles.txtCapas,'Enable','on');
           set(handles.txtNNeuronas,'Enable','on');
           set(handles.txtNeuronas,'Enable','on');
           set(handles.lstboxEntrenamiento,'Enable','on');
           set(handles.btnAgregar,'Enable','on');
           set(handles.btnNewff,'Enable','on');
           set(handles.txtIteraciones,'Enable','off');
           set(handles.m1,'Enable','on');
           set(handles.txtNumeroNeuronas,'Enable','off');
           set(handles.txtPuntos,'Enable','off');  
           set(handles.btnCompet,'Enable','off');
           set(handles.txtIteraciones,'Enable','on');
       otherwise, '';
   end

function txtIteraciones_Callback(hObject, eventdata, handles)
Val=get(hObject,'String');
handles.txtIteraciones=Val;
guidata(hObject,handles);


% --- Executes during object creation, after setting all properties.
function txtIteraciones_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtIteraciones (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
