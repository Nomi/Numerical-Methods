function butterflyAnimFn(UIAxes, fps_,time_,mvmntspdScale,flapW,flapFramesDur, colorChgs, angleRotTotal)

%%%Title:%%%
%% A Butterfly and a Windy Day %%


rng shuffle;   %seeding rng for rand (time based, so no repetition)

%%%%%%Animation Parameters:%%%%%%
flapWings=flapW;           %sets wether wings should be flapped. %if true, movement done at times of wing flapping only.
anglTotal = angleRotTotal;    %Total rotation needed throughout the animation. 
mvSpdScl=mvmntspdScale;                %Sets movement speed.
fps=fps_;                   %frames per second
colorChanges=colorChgs;          %Number of Color Changes (Presets: 0=Disable, Negative=Changes Each frame) 
apprxRuntime=time_;          %How long the animation should be (seconds)
flapDuration=flapFramesDur;          %How many frames should each complete flap last
%Note: fps=60*n , and colorChanges==approxRuntime, flapDuration==30 implies that color changes after
%each n times wing flaps completely.
bfSS=1;%2;                   %butteflySizeScale: 1=default. 0.5<=bfSS<=0.5 
pltLW=10;                  %line width of the plot.
frames=fps*apprxRuntime;    %Calculatres total number of frames using runtime and frames per second


%%%%%%Drawing Base Butterfly:%%%%%%
src=[-2*bfSS,-2*bfSS,2*bfSS,2*bfSS,-2*bfSS,-2*bfSS,0,0,0;
    -2*bfSS,2*bfSS,-2*bfSS,2*bfSS,-2*bfSS,2*bfSS,0,-1*bfSS,1*bfSS];
hold(UIAxes,'off')
drawnow;
plt=plot(UIAxes,src(1,:),src(2,:), 'linewidth', pltLW);
drawnow;
hold(UIAxes,'on')
%axis vis3d;
%%%%%%Animating%%%%%%
fAngl=anglTotal/(frames-1); %fAngl stores angle to rotate in each frame %frames-1 because we already used a frame on drawing the initial thing.
fSrc=src; %fSrc will be the source for each new frame
folded=false;   %Sets the starting status of wings to be not folded.
axDim=axis(UIAxes);     %Axis dimensions
mov=[30/(flapDuration/2);30/(flapDuration/2)]; %Just sets a relatively okay base movement speed
for i=1:(frames-1)   %i counts frames drawn so far %frames-1 because we already used a frame on drawing the initial thing.
    pause(apprxRuntime/(frames-1)); %pauses to maintain framerate.
    rotMtrx = [cos(fAngl) -sin(fAngl); sin(fAngl) cos(fAngl)]; % rotation matrix
    fSrc=(rotMtrx*fSrc);%Applies rotation.
    
    %The following manages color changes:
    if(colorChanges<0)
        col=mod(get(plt, 'Color')+rand(1,3),1);
    elseif(colorChanges==0)
        col=get(plt, 'Color');
    else %colorChanges>0
        if(mod(i,floor(frames/colorChanges))==0)
            col=rand(1,3);
        else
            col=get(plt, 'Color');
        end
    end
    
    %The following section handles movement when flapWings is disabled
    if(flapWings==false)
        mov = mvSpdScl*[(2*rand(1)-1)/2; (2*rand(1)-1)/2;]; %Generates random movement.
        fSrc=(fSrc)+mov;    %Applies generated movement and rotation matrix
    end
    
    %The follwing section flaps the wings if enabled (and handles movement
    %in that case.)
    %Flap wings
    if(flapWings)
        if(mod(i,flapDuration/2)==0)    %Changes state after every flapDuration/2 frames because each flap takes flapDuration/2 frames each for unfolded and folded state.
            if(folded==false)
                wingMov=[1*bfSS,1*bfSS,-1*bfSS,-1*bfSS,1*bfSS,1*bfSS,0,0,0;
                         0,0,0,0,0,0,0,0,0];
                fSrc=((fSrc)+mov*mvSpdScl)+rotMtrx*wingMov;
                folded=true;
            else
                wingMov=[-1*bfSS,-1*bfSS,1*bfSS,1*bfSS,-1*bfSS,-1*bfSS,0,0,0;
                         0,0,0,0,0,0,0,0,0];
                fSrc=((fSrc)+mov*mvSpdScl)+rotMtrx*wingMov;
                folded=false;
            end
        end
    end
    
    %The following if condition tries to stop the shape (including linewidth) from going outside bounds.
    if (all(any(fSrc+pltLW/2>10))||all(any(fSrc-pltLW/2<-10))) 
        fSrc=fSrc-mov;    
        if(flapWings)
            mov=-1*mov;
        end
    end
    %The following applies all the Animation done so far:
    %plot(UIAxes, fSrc(1,:), fSrc(2,:), )
    set(plt,'Xdata',fSrc(1,:),'Ydata',fSrc(2,:),'color',col);
    %axis([-10*aR 10*aR -10 10]);    %sets the axis according to the aspect ratio needed.
end
    hold(UIAxes,'off');