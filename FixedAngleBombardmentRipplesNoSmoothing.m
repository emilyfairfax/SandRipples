%Ripple Formation Model
%written by Emily Fairfax
%March 30th, 2016

%% Initialize

clear all

%Space Array
xmin = 1; %minimum position in x, particle lengths
xmax = 3000; %maxiumum position in x, particle lengths
dx = 1; %spacing in x, 1 particle length
x = xmin:dx:xmax; %x array

%Topography
sand_amp = 2; %amplitude of the wave in the intial sand topography
sand_period = 5000; %period of oscillation in sand topography
sand_elevation = 1000+sand_amp*sin(2*pi*x/sand_period); %equation for the initial sand topography

%Particle Rain
total_shots = 1500; %total shots to fire
scattering_distance = 100; %distance moved by particles ejected during granular splash
net_particles_sprayed = 3; %total change in particles at impact site (accounts for either particle stick or rebound of incoming shot)
N = total_shots+1; %for running loop
particles_per_shot = 200; %how many particles rain down each loop step


%For Plotting
nplots = 100; %number of plots to make
plotted_shots = total_shots/nplots; %when to plot
xx = [x, fliplr(x)]; %for filling plot
bottomline=-200000000.*ones(1,xmax); %Create a bottom line array for use in filling plots, needs to be same length as N


%% Run
for i = 2:N %loop thru total number of shots
    
    %endbc(i) = sand_elevation(xmax);
    for k = 1:particles_per_shot %loop thru all the particles fired in a single shot
     
    %Particle Rain
    firing_angle = 20; %angle the particles are shot, measured down from horizontal
    firing_height(k) = 1000+10*k; %various heights particles are shot from, evenly space
    firing_slope = -tand(firing_angle); %turn the angle into a slope
    firing_line = firing_height(k)+x*firing_slope; %these are the lines of approach for each particle in the shot
    
    %Hit the sand bed
    if firing_line(xmax)<sand_elevation(xmax) %if the particle will hit the bed before xmax
        intercept_point(k) = find(firing_line <= sand_elevation,1); %the intercept point is the first place the bed elevation and firing line cross
    else %if it wont hit the bed 
        intercept_point(k) = -1; %set arbitrary imaginary "impact point", this is in essence a "miss"
    end
    end
    
    for j = 1:particles_per_shot; %loop through all the particles in each shot again
        if intercept_point(j) ~=-1 %if they did not miss the sand bed
            if sand_elevation(intercept_point(j))>=0 %and if the sand elevation at the intercept point is greater than zero (no sand)
                sand_elevation(intercept_point(j)) = sand_elevation(intercept_point(j))-net_particles_sprayed; %then blast away the net particles sprayed
                if intercept_point(j)+scattering_distance<=xmax %and if the the place the spray to is less than or equal to the max x
                    sand_elevation(intercept_point(j)+scattering_distance) = sand_elevation(intercept_point(j)+scattering_distance)+net_particles_sprayed; %add them on to the place they land
                else %if they would land farther than the max x
                   sand_elevation(intercept_point(j)+scattering_distance-xmax) = sand_elevation(intercept_point(j)+scattering_distance-xmax)+net_particles_sprayed; %loop it around and have them spray to the appropriate looped position in the beginning of x
                end
            else
                sand_elevation(intercept_point(j)) = 1; %if the sand elevation at the interecept is zero, just stick the incoming particle on to it.
            end
        end
    end
    
    % Apply a Noise Filter to Smooth Ripple Shape (diffusion-ish, single sand grains dont actually stack on top each other 100 high)
    windowsize = 100; %bins 100 grains wide get averaged
    b = (1/windowsize)*ones(1,windowsize);
    a = 1;
    smoothsand = filter(b,a,sand_elevation); %smooth out the sand stacks into 100 grain bins
    
    smoothsand(1:100)=smoothsand((xmax-99):xmax); %wrap around BC, use filter window size
    
    %Representative Shots for Plotting, these are lines to demonstrate the
    %incoming particles
    shotplot1 = 1000+x*firing_slope;
    shotplot2 = 1100+x*firing_slope;
    shotplot3 = 1200+x*firing_slope;
    shotplot4 = 1300+x*firing_slope;
    shotplot5 = 1400+x*firing_slope;
    shotplot6 = 1500+x*firing_slope;
    shotplot7 = 1600+x*firing_slope;
    shotplot8 = 1700+x*firing_slope;
    shotplot9 = 1800+x*firing_slope;
    shotplot10 = 1900+x*firing_slope;
    shotplot11 = 2000+x*firing_slope;
    shotplot12 = 2100+x*firing_slope;
    shotplot13 = 2200+x*firing_slope;
    shotplot14 = 2300+x*firing_slope;
    shotplot15 = 2400+x*firing_slope;
    shotplot16 = 2500+x*firing_slope;
    shotplot17 = 2600+x*firing_slope;
    shotplot18 = 2700+x*firing_slope;
    shotplot19 = 2800+x*firing_slope;
    shotplot20 = 2900+x*firing_slope;
    shotplot21 = 3100+x*firing_slope;
    shotplot22 = 3200+x*firing_slope;
    shotplot23 = 3300+x*firing_slope;
    shotplot24 = 3400+x*firing_slope;
    shotplot25 = 3500+x*firing_slope;
    shotplot26 = 3600+x*firing_slope;
    shotplot27 = 3000+x*firing_slope;
    shotplot28 = 3700+x*firing_slope;
    shotplot29 = 3800+x*firing_slope;
    shotplot30 = 3900+x*firing_slope;
    shotplot31 = 4000+x*firing_slope;
    shotplot32 = 4100+x*firing_slope;
    
    
  
    %Plotting
    if rem(i,plotted_shots)==0 
    figure(1)
    clf
    
    %Incoming Sand Plots, this is the "particle rain"
    plot(x,shotplot1,'--','Color',[.859,.82,.702])
    hold all
    plot(x,shotplot2,'--','Color',[.859,.82,.702])
    plot(x,shotplot3,'--','Color',[.859,.82,.702])
    plot(x,shotplot4,'--','Color',[.859,.82,.702])
    plot(x,shotplot5,'--','Color',[.859,.82,.702])
    plot(x,shotplot6,'--','Color',[.859,.82,.702])
    plot(x,shotplot7,'--','Color',[.859,.82,.702])
    plot(x,shotplot8,'--','Color',[.859,.82,.702])
    plot(x,shotplot9,'--','Color',[.859,.82,.702])
    plot(x,shotplot10,'--','Color',[.859,.82,.702])
    plot(x,shotplot11,'--','Color',[.859,.82,.702])
    plot(x,shotplot12,'--','Color',[.859,.82,.702])
    plot(x,shotplot13,'--','Color',[.859,.82,.702])
    plot(x,shotplot14,'--','Color',[.859,.82,.702])
    plot(x,shotplot15,'--','Color',[.859,.82,.702])
    plot(x,shotplot16,'--','Color',[.859,.82,.702])
    plot(x,shotplot17,'--','Color',[.859,.82,.702])
    plot(x,shotplot18,'--','Color',[.859,.82,.702])
    plot(x,shotplot19,'--','Color',[.859,.82,.702])
    plot(x,shotplot20,'--','Color',[.859,.82,.702])
    plot(x,shotplot21,'--','Color',[.859,.82,.702])
    plot(x,shotplot22,'--','Color',[.859,.82,.702])
    plot(x,shotplot23,'--','Color',[.859,.82,.702])
    plot(x,shotplot24,'--','Color',[.859,.82,.702])
    plot(x,shotplot25,'--','Color',[.859,.82,.702])
    plot(x,shotplot26,'--','Color',[.859,.82,.702])
    plot(x,shotplot27,'--','Color',[.859,.82,.702])
    plot(x,shotplot28,'--','Color',[.859,.82,.702])
    plot(x,shotplot29,'--','Color',[.859,.82,.702])
    plot(x,shotplot30,'--','Color',[.859,.82,.702])
    plot(x,shotplot31,'--','Color',[.859,.82,.702])
    plot(x,shotplot32,'--','Color',[.859,.82,.702])
    
    %Fill Sand Elevation
    yy = [bottomline, fliplr(sand_elevation)];
    fill(xx,yy,[.796, .737, .565]);
    
    %Sand Elevation Line
    plot(x,sand_elevation,'k','Linewidth',3)
    %plot formatting
    title('Sand Profile Evolution with Fixed Angle Particle Bombardment');
    xlabel('Distance Along Profile (grains)');
    ylabel('Sand Height (grains)');
    set(gca,'fontsize',16,'fontname','arial')    
    axis([0 xmax 900 1500])
    
    pause(0.01)
    end
    
    
end
   