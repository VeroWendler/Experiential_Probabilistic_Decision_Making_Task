% 09.08.2023    EXPERIMENT 1 - Experiential Neglect 
% 
% Pilot Study on Symbolic/Experiential Neglect
% This program is a pilot study to determine the optimal number of
% conditions and trials to use in the main experiment testing the
% hypothesis that the experiential neglect observed by Garcia et al. (2022/23)
% is due to uncertainty in the probability estimation of the experiential
% icons.

set(0,'DefaultFigureVisible','on');        
clear;
sca;  
PsychDefaultSetup(2);             
blankDuration = 0.6; 
screens = Screen('Screens');        
screenNumber = max(screens); 
black = BlackIndex(screenNumber);
white = WhiteIndex(screenNumber);
grey = white;    
      
[window, windowRect] = PsychImaging('OpenWindow', screenNumber, grey);
Screen('BlendFunction', window, 'GL_SRC_ALPHA', 'GL_ONE_MINUS_SRC_ALPHA');
[screenXpixels, screenYpixels] = Screen('WindowSize', window);
[xCenter, yCenter] = RectCenter(windowRect);
ifi = Screen('GetFlipInterval', window);
[xCenter, yCenter] = RectCenter(windowRect);
Screen('BlendFunction', window, 'GL_SRC_ALPHA', 'GL_ONE_MINUS_SRC_ALPHA');        
% Introduction Message 

line1 = 'Welcome to this experiment. This experiment is composed of 3 main steps:';
line2 = '\n\n 1)Training Phase: You will get introduced to the 3 different tests.';
line3 = '\n\n\n 2) 1. Phase of the experiment: You will play a longer version of the 3 different tests.';
line4 = '\n\n\n 3)	2. Phase: We will ask you how confident you are about your choices.';
line5 = '\n\n\n In addition to the fixed compensation of £16 you will be endowed with an additional £2,';
line6 = '\n\n\n depending on your choices you can either lose or double this endowment!';
line7 = '\n\n\nPlease press the space bar to continue';
Screen('TextSize', window, 18);
DrawFormattedText(window, [line1 line2 line3 line4 line5 line6 line7],...
    'center', screenYpixels * 0.3, black);
Screen('Flip', window);
KbStrokeWait;

line8 = 'TRAINING: Instructions for the first training test:';
line9 = '\n\n In each round, you have to choose between one of two symbols displayed on either side of the screen.';
line10 = '\n\n\n To select the left symbol, use the "a" key; to select the right symbol, use the "k" key.';
line11 = '\n\n\n After a choice, you can win/lose the following outcomes:';
line12 = '\n\n\n 1 point = 0.002 pence'; 
line13 = '\n\n\n -1 point = -0.002 pence';
line14 = '\n\n\n Remember, in total, you can win up to £4 additional money.';
line15 = '\n\n\n Please note that only the outcome of your choice will be considered in the final payoff.';
line16 = '\n\n\n Please also note that only the points won during the Experiment will count towards your payoff.';
line17 = '\n\n\n Please note that only the outcome of your choice will be considered in the final payoff.';
line18 = '\n\n\n Please press the space bar to continue.';
Screen('TextSize', window, 18);
DrawFormattedText(window, [line8 line9 line10 line11 line12 line13 line14 line15 line16 line17 line18],...
    'center', screenYpixels * 0.25, black);
Screen('Flip', window);
KbStrokeWait;

line19 = 'Here are some example stimuli and their respective outcomes:';
line20 = '\n\n\n Please press the space bar to continue.';
Screen('TextSize', window, 18);
DrawFormattedText(window, [line19 line20],...
    'center', screenYpixels * 0.25, black);
Screen('Flip', window);
KbStrokeWait;

startMessage = 'Press any key to start the trials.';
Screen('TextSize', window, 18);
DrawFormattedText(window, startMessage, 'center', 'center', black);
Screen('Flip', window);
KbStrokeWait;

% Loading and resizing the images 
Fire = imread("Fire.png");
Equal = imread("Equal.png");
Neg = imread("-1.png");
Pos = imread("1.png");
Circle = imread("Test_Icons_Additional_Circle.png");
Cursor = imread("Test_Icons_Additional_Cursor.png");
Folder = imread("Test_Icons_Additional_Folder.png");
Magnet = imread("Test_Icons_Additional_Magnet.png");
Mark = imread("Test_Icons_Mark.png");
TRArrow = imread("Test_Icons_Additional_TRArrow.png");
AI = imread("Test_Icons_AI.png");
At = imread("Test_Icons_At.png");
Cloud = imread("Test_Icons_Cloud.png");
Cycle = imread("Test_Icons_Cycle.png");
Hazel = imread("Test_Icons_Hazel.png");
Star = imread("Test_Icons_Star.png");

imageSize = [268, 268];
Fire = imresize(Fire, imageSize);
Equal = imresize(Equal, imageSize);
Neg = imresize(Neg, imageSize);
Pos = imresize(Pos, imageSize);
Circle = imresize(Circle, imageSize);
Cursor = imresize(Cursor, imageSize);
Folder = imresize(Folder, imageSize);
Magnet = imresize(Magnet, imageSize);
Mark = imresize(Mark, imageSize);
TRArrow = imresize(TRArrow, imageSize);
AI = imresize(AI, imageSize);
At = imresize(At, imageSize);
Cloud = imresize(Cloud, imageSize);
Cycle = imresize(Cycle, imageSize);
Hazel = imresize(Hazel, imageSize);
Star = imresize(Star, imageSize);

allImagesTEST = {Fire, Equal, Circle, Cursor, Folder, Magnet, Mark, TRArrow, AI, At, Cloud, Cycle, Hazel, Star};
allImageNamesTEST = {'Fire', 'Equal', 'Circle', 'Cursor', 'Folder', 'Magnet', 'Mark', 'TRArrow', 'AI', 'At', 'Cloud', 'Cycle', 'Hazel', 'Star'};

% probability arrays
C = [0.2, 0.8];
D = [0.8, 0.2];
E = [0.4, 0.6];
F = [0.6, 0.4];
G = [0, 1];
H = [1, 0];

allProbabilityArraysTEST = {C, D, E, F, G, H};
allProbabilityNamesTEST = {'C', 'D', 'E', 'F', 'G', 'H'};

% separation between images to be depicted on screen
separation = 300; 
blockSize1and2TEST1 = 10;
blockSize3TEST1 = 10;

% Variables Test 1 
selectedImagesFromFirstPartTEST = cell(3, 2);
selectedProbabilitiesFromFirstPartTEST = zeros(3, 2);
elapsedTimeTEST1 = zeros(2 * blockSize1and2TEST1 + blockSize3TEST1, 1);
leftimTEST1 = cell(3, 1);
rightimTEST1 = cell(3, 1);
clicksArrayTEST1 = zeros(2 * blockSize1and2TEST1 + blockSize3TEST1, 1);
leftOutcomesTEST1 = zeros(1, 2 * blockSize1and2TEST1 + blockSize3TEST1);
rightOutcomesTEST1 = zeros(1, 2 * blockSize1and2TEST1 + blockSize3TEST1);
numTrialsTEST1 = 2 * blockSize1and2TEST1 + blockSize3TEST1;
scoreArrayTEST1 = zeros(numTrialsTEST1, 1);
utility_ArrayTEST1 = zeros(numTrialsTEST1, 1);
Out_LeftTEST1 = zeros(numTrialsTEST1, 1);
Out_RightTEST1 = zeros(numTrialsTEST1, 1);


dataCellTEST1 = {
    selectedImagesFromFirstPartTEST,
    selectedProbabilitiesFromFirstPartTEST,
    elapsedTimeTEST1,
    leftimTEST1,
    rightimTEST1,
    leftOutcomesTEST1,
    rightOutcomesTEST1,
    numTrialsTEST1,
    scoreArrayTEST1,
    clicksArrayTEST1,
    utility_ArrayTEST1,
    Out_LeftTEST1,
    Out_RightTEST1
};

filename = 'p_data_TEST1.mat';

scoreTEST1 = 0;
trialNumTEST1 = 0;

% Running the Blocks - Image selection without replacement
% What happens here: We introduce a flagging procedure that ensures no
% image is selected twice and will occur again in another block,
% strcmp(selectedImagesFromFirstPartTEST, name1TEST) and
% strcmp(selectedImagesFromFirstPartTEST, name2TEST) create matrices that
% check if each element in the selectedImagesFromFirstPart is equal to
% name1TEST and name2TEST. Any(any(...) checks if the element in the
% matrices is 'true', if so repeat is set to false ensuring no image is
% slected twice. image1TEST and image2TEST hold the data of the images
% selected through the selectedIndicesTEST vectors from our TEST images.
% The images and their texture are then assigned to the blocks.

for block = 1:3
    repeats = true;
    while repeats
        selectedIndicesTEST = randperm(numel(allImagesTEST), 2);
        name1TEST1 = allImageNamesTEST(selectedIndicesTEST(1));
        name2TEST1 = allImageNamesTEST(selectedIndicesTEST(2));
        if ~ any(any(strcmp(selectedImagesFromFirstPartTEST, name1TEST1))) & ~ any(any(strcmp(selectedImagesFromFirstPartTEST, name2TEST1)))
            repeats = false;
        end
    end

    image1TEST1 = allImagesTEST{selectedIndicesTEST(1)};
    image2TEST1 = allImagesTEST{selectedIndicesTEST(2)};

    selectedImagesFromFirstPartTEST(block, 1) = allImageNamesTEST(selectedIndicesTEST(1));
    selectedImagesFromFirstPartTEST(block, 2) = allImageNamesTEST(selectedIndicesTEST(2));

    texture1TEST1 = Screen('MakeTexture', window, image1TEST1);
    texture2TEST1 = Screen('MakeTexture', window, image2TEST1);

    % here we select the probability array randomly for the block
    chosenProbabilityIndexTEST = randi(numel(allProbabilityArraysTEST));
    chosenProbabilityArrayTEST = cell2mat(allProbabilityArraysTEST(chosenProbabilityIndexTEST));
    selectedProbabilitiesFromFirstPartTEST(block, 1) = chosenProbabilityArrayTEST(1);
    selectedProbabilitiesFromFirstPartTEST(block, 2) = chosenProbabilityArrayTEST(2);
    
    % here, we assign blocksizes based on trial numbers
    if block == 3
        trialsInBlockTEST1 = blockSize3TEST1;
    else
        trialsInBlockTEST1 = blockSize1and2TEST1;
    end

    %this here is difficult, but works like this: We create arrays of ones
    %and minus oens that occur in number accoridng to the given probability
    %array and its complement P'. Then, the horzcat will horizontally
    %concatenate these and the randomized selection procedure is gnereated
    %through the shuffle function. We assesss the number of trials where
    %the outcome is minus one and the number of trials where the outcome
    %eis one.
    outcomes1TEST1 = Shuffle(horzcat(-1 * ones(1, int32(trialsInBlockTEST1 * (1 - chosenProbabilityArrayTEST(1)))), ones(1, int32(trialsInBlockTEST1 * chosenProbabilityArrayTEST(1)))));
    outcomes2TEST1 = Shuffle(horzcat(-1 * ones(1, int32(trialsInBlockTEST1 * (1 - chosenProbabilityArrayTEST(2)))), ones(1, int32(trialsInBlockTEST1 * chosenProbabilityArrayTEST(2)))));

    % here, we select the position of the images on screen and also store
    % the data for outcomes and images associated with the position
    for trial = 1:trialsInBlockTEST1
        trialNumTEST1 = trialNumTEST1 + 1;
        randomPositionsTEST1 = randperm(2);
        position1TEST1 = randomPositionsTEST1(1);
        position2TEST1 = randomPositionsTEST1(2);

        vbl = Screen('Flip', window);

        if position1TEST1 == 1
            Screen('DrawTexture', window, texture1TEST1, [], [xCenter-separation/2-imageSize(1) yCenter-imageSize(2)/2 xCenter-separation/2 yCenter+imageSize(2)/2], 0);
            Screen('DrawTexture', window, texture2TEST1, [], [xCenter+separation/2 yCenter-imageSize(2)/2 xCenter+separation/2+imageSize(1) yCenter+imageSize(2)/2], 0);
            outcome1TEST1 = outcomes1TEST1(trial);
            outcome2TEST1 = outcomes2TEST1(trial);
            leftimTEST1{trialNumTEST1} = selectedImagesFromFirstPartTEST{block, 1};
            rightimTEST1{trialNumTEST1} = selectedImagesFromFirstPartTEST{block, 2};

            elseif position2TEST1 == 1
            Screen('DrawTexture', window, texture1TEST1, [], [xCenter+separation/2 yCenter-imageSize(2)/2 xCenter+separation/2+imageSize(1) yCenter+imageSize(2)/2], 0);
            Screen('DrawTexture', window, texture2TEST1, [], [xCenter-separation/2-imageSize(1) yCenter-imageSize(2)/2 xCenter-separation/2 yCenter+imageSize(2)/2], 0);
            outcome1TEST1 = outcomes2TEST1(trial);
            outcome2TEST1 = outcomes1TEST1(trial);
            leftimTEST1{trialNumTEST1} = selectedImagesFromFirstPartTEST{block, 2};
            rightimTEST1{trialNumTEST1} = selectedImagesFromFirstPartTEST{block, 1};
        end

        vbl = Screen('Flip', window, vbl + (1 - 0.5) * ifi);                                      % we could also remove the (1-0.5) * ifi 
                                                                                                  % here, we start measuring the response time using tic toc functions. This will be saved in
                                                                                                  % the elapsed variable 
        tic();
        % Wait for key press to chose image
        selectedImageTEST1 = '';
        while isempty(selectedImageTEST1)
            [~, keyCode, ~] = KbWait;
            keyPressed = KbName(find(keyCode));
           
            if strcmp(keyPressed, 'a')       
                selectedImageTEST1 = 'left';
                clicksArrayTEST1(trialNumTEST1) = 1;    %stores left click (1) in the array
                leftOutcomesTEST1(trialNumTEST1) = outcome1TEST1;
                rightOutcomesTEST1(trialNumTEST1) = outcome2TEST1;
            elseif strcmp(keyPressed, 'k')
                selectedImageTEST1 = 'right';
                clicksArrayTEST1(trialNumTEST1) = 0;   %stores right click (2) in the array
                leftOutcomesTEST1(trialNumTEST1) = outcome2TEST1;
                rightOutcomesTEST1(trialNumTEST1) = outcome1TEST1;
            end
        end
        elapsedTimeTEST1(trialNumTEST1) = toc();

%         % Calculate utility for the trial based on selected probabilities and outcomes
%         if strcmp(selectedImageTEST1, 'left')
%             if outcome1TEST1 > outcome2TEST1
%                 utility_ArrayTEST1(trialNumTEST1) = 1;
%                 scoreTEST1 = scoreTEST1 + 1;
%             else
%                 utility_ArrayTEST1(trialNumTEST1) = 0;
%                 scoreTEST1 = scoreTEST1 - 1;
%             end
%         elseif strcmp(selectedImageTEST1, 'right')
%             if outcome2TEST1 > outcome1TEST1
%                 utility_ArrayTEST1(trialNumTEST1) = 1;
%                 scoreTEST1 = scoreTEST1 + 1;
%             else
%                 utility_ArrayTEST1(trialNumTEST1) = 0;
%                 scoreTEST1 = scoreTEST1 - 1;
%             end
%         end
%         scoreArrayTEST1(trialNumTEST1) = scoreTEST1;


% Calculate utility for the trial based on selected probabilities and outcomes
    if strcmp(selectedImageTEST1, 'left')
        if outcome1TEST1 == 1  
            scoreTEST1 = scoreTEST1 + 1;  
            utility_ArrayTEST1(trialNumTEST1) = 1;
        else  
            scoreTEST1 = scoreTEST1 - 1;  
            utility_ArrayTEST1(trialNumTEST1) = 0;
        end
    elseif strcmp(selectedImageTEST1, 'right')
        if outcome2TEST1 == 1  
            scoreTEST1 = scoreTEST1 + 1;  
            utility_ArrayTEST1(trialNumTEST1) = 1;
        else  
            scoreTEST1 = scoreTEST1 - 1;  
            utility_ArrayTEST1(trialNumTEST1) = 0;
        end
    end
    scoreArrayTEST1(trialNumTEST1) = scoreTEST1;


        % here, we define the rectangle outline which appears around the
        % clicked image
        if strcmp(selectedImageTEST1, 'left')
            if position1TEST1 == 1
                Screen('DrawTexture', window, texture1TEST1, [], [xCenter-separation/2-imageSize(1) yCenter-imageSize(2)/2 xCenter-separation/2 yCenter+imageSize(2)/2], 0);
                Screen('FrameRect', window, [0, 255, 0], [xCenter-separation/2-imageSize(1)-10 yCenter-imageSize(2)/2-10 xCenter-separation/2+10 yCenter+imageSize(2)/2+10], 3);
                Screen('DrawTexture', window, texture2TEST1, [], [xCenter+separation/2 yCenter-imageSize(2)/2 xCenter+separation/2+imageSize(1) yCenter+imageSize(2)/2], 0);
            else
                Screen('DrawTexture', window, texture2TEST1, [], [xCenter-separation/2-imageSize(1) yCenter-imageSize(2)/2 xCenter-separation/2 yCenter+imageSize(2)/2], 0);
                Screen('FrameRect', window, [0, 255, 0], [xCenter-separation/2-imageSize(1)-10 yCenter-imageSize(2)/2-10 xCenter-separation/2+10 yCenter+imageSize(2)/2+10], 3);
                Screen('DrawTexture', window, texture1TEST1, [], [xCenter+separation/2 yCenter-imageSize(2)/2 xCenter+separation/2+imageSize(1) yCenter+imageSize(2)/2], 0);
            end
        elseif strcmp(selectedImageTEST1, 'right')
            if position1TEST1 == 2
                Screen('DrawTexture', window, texture1TEST1, [], [xCenter+separation/2 yCenter-imageSize(2)/2 xCenter+separation/2+imageSize(1) yCenter+imageSize(2)/2], 0);
                Screen('FrameRect', window, [0, 255, 0], [xCenter+separation/2-10 yCenter-imageSize(2)/2-10 xCenter+separation/2+imageSize(1)+10 yCenter+imageSize(2)/2+10], 3);
                Screen('DrawTexture', window, texture2TEST1, [], [xCenter-separation/2-imageSize(1) yCenter-imageSize(2)/2 xCenter-separation/2 yCenter+imageSize(2)/2], 0);
            else
                Screen('DrawTexture', window, texture2TEST1, [], [xCenter+separation/2 yCenter-imageSize(2)/2 xCenter+separation/2+imageSize(1) yCenter+imageSize(2)/2], 0);
                Screen('FrameRect', window, [0, 255, 0], [xCenter+separation/2-10 yCenter-imageSize(2)/2-10 xCenter+separation/2+imageSize(1)+10 yCenter+imageSize(2)/2+10], 3);
                Screen('DrawTexture', window, texture1TEST1, [], [xCenter-separation/2-imageSize(1) yCenter-imageSize(2)/2 xCenter-separation/2 yCenter+imageSize(2)/2], 0);
            end
        end
        vbl = Screen('Flip', window);
        WaitSecs(blankDuration);

        % pos and neg images based on the chosen probability array
        posTextureTEST1 = Screen('MakeTexture', window, Pos);
        negTextureTEST1 = Screen('MakeTexture', window, Neg);

        vbl = Screen('Flip', window);
   
        %If outcome1TEST is equal to 1, the positive image is drawn on the left side of the screen.
        %If outcome1TEST is not equal to 1, the negative image is drawn on
        %the left side of the screen. The same goes for outcome2TEST
        %initially determiend by the shuffle(horzcat( ...array

        if outcome1TEST1 == 1
            Out_LeftTEST1(trialNumTEST1) = 1;  % here we store the positive outcome for left side                                            !WORK HERE!
            Screen('DrawTexture', window, posTextureTEST1, [], [xCenter-separation/2-imageSize(1) yCenter-imageSize(2)/2 xCenter-separation/2 yCenter+imageSize(2)/2], 0);
        else
            Out_LeftTEST1(trialNumTEST1) = -1;  % here we store the negative outcome for left side
            Screen('DrawTexture', window, negTextureTEST1, [], [xCenter-separation/2-imageSize(1) yCenter-imageSize(2)/2 xCenter-separation/2 yCenter+imageSize(2)/2], 0);
        end
        if outcome2TEST1 == 1
            Out_RightTEST1(trialNumTEST1) = 1;  % we store the positive outcome for right side
            Screen('DrawTexture', window, posTextureTEST1, [], [xCenter+separation/2 yCenter-imageSize(2)/2 xCenter+separation/2+imageSize(1) yCenter+imageSize(2)/2], 0);
        else
            Out_RightTEST1(trialNumTEST1) = -1;  % we store the negative outcome for right side
            Screen('DrawTexture', window, negTextureTEST1, [], [xCenter+separation/2 yCenter-imageSize(2)/2 xCenter+separation/2+imageSize(1) yCenter+imageSize(2)/2], 0);
        end
        vbl = Screen('Flip', window, vbl + (1 - 0.5) * ifi);
        WaitSecs(blankDuration);
        Screen('FillRect', window, white);
        Screen('Flip', window);
    end
end

save(filename, 'selectedImagesFromFirstPartTEST', 'selectedProbabilitiesFromFirstPartTEST', 'elapsedTimeTEST1','leftimTEST1','rightimTEST1', 'numTrialsTEST1', 'scoreArrayTEST1', 'clicksArrayTEST1', 'utility_ArrayTEST1', 'Out_RightTEST1', 'Out_LeftTEST1', 'rightOutcomesTEST1', 'leftOutcomesTEST1');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%% Testing Phase: ES- Phase  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Instructions for the second training test: ES-Phase
line21 = 'TRAINING: Instructions for the second test:';
line22 = '\n\n  In the second test there will be two kinds of options.';
line23 = '\n\n\n  The first kind of option is represented by the symbols you already encountered during the previous test.';
line24 = '\n\n\n  Note: The symbols maintain the same odds of winning/losing a point as in the first test.';
line25 = '\n\n\n  The second kind of options is represented by pie-charts that describe the odds of winning/losing points';
line26 = '\n\n\n  through interleaved segments of specific green/red ratios.';
line27 = '\n\n\n  Specifically, the amount of green area indicates the chance of winning a point;';
line28 = '\n\n\n  the amount of red area indicates the chance of losing a point.';
line29 = '\n\n\n  These pie-charts will be of various types (one example is shown in the testing phase)';
line30 = '\n\n\n  Just as for the logos, pie-charts range from 90% chance of winning a point to 90% chance of losing a point.';
line31 = '\n\n\n  You will always be asked to chose between a pie-chart and an icon.';
line32 = '\n\n\n Please press the space bar to continue.';
Screen('TextSize', window, 18);
DrawFormattedText(window, [line21 line22 line23 line24 line25 line26 line27 line28 line29 line30 line31 line32],...
    'center', screenYpixels * 0.25, black);
Screen('Flip', window);
KbStrokeWait;

line33 = 'TRAINING: Instructions for the second test:';
line34= '\n\n In each round, you have to choose between one of two symbols displayed on either side of the screen.';
line35 = '\n\n\n  You can select the left symbol by presseing "a" and the right symbol by pressing "k" on your keyboard.';
line36 = '\n\n\n  Please note that in this test, no outcome will be displayed,';
line37 = '\n\n\n  such that after a choice, the next pair of options will be shown without an intermediate step.'; 
line38 = '\n\n\n  At the end of the test, you will be shown the final payoff in terms of cumulative points and monetary bonus';
line39 = '\n\n\n Please press the space bar to continue.';
Screen('TextSize', window, 18);
DrawFormattedText(window, [line33 line34  line35 line36 line37 line38 line39],...
    'center', screenYpixels * 0.25, black);
Screen('Flip', window);
KbStrokeWait;

line40 = 'Note: Points won during the training do not count towards the final payoff!';
line41 = 'Let4s begin with the second training test';
line42 = '\n\n\n Please press the space bar to continue.';
Screen('TextSize', window, 18);
DrawFormattedText(window, [line40 line41 line42],...
    'center', screenYpixels * 0.25, black);
Screen('Flip', window);
KbStrokeWait;

allPieChartProbabilitiesTEST2 = [1/8 2/8 3/8 4/8 5/8 6/8 7/8];

blockSizeSecondPartTEST = 10;
% blankDuration = 0.2;
scoreArraySecondPartTEST = zeros(2 * blockSizeSecondPartTEST, 1);
clicksArrayTEST2 = zeros(2 * blockSizeSecondPartTEST, 1);
elapsedTimeTEST2 = zeros(2 * blockSizeSecondPartTEST, 1);
selectedLeftProbabilitiesTEST2 = zeros(2 * blockSizeSecondPartTEST, 1);
selectedRightProbabilitiesTEST2 = zeros(2 * blockSizeSecondPartTEST, 1);
outcomeArrayTEST2 = zeros(2 * blockSizeSecondPartTEST, 1);                                                                % Array to store outcomes (1 for win, 0 for loss)
leftimTEST2 = cell(2 * blockSizeSecondPartTEST, 1);
rightimTEST2 = cell(2 * blockSizeSecondPartTEST, 1);
utility_ArrayTEST2 = zeros(2 * blockSizeSecondPartTEST, 1);


dataCellTEST2 = {
    scoreArraySecondPartTEST,
    clicksArrayTEST2,
    elapsedTimeTEST2,
    selectedLeftProbabilitiesTEST2,
    selectedRightProbabilitiesTEST2,
    outcomeArrayTEST2,
    leftimTEST2,
    rightimTEST2,
    utility_ArrayTEST2
};

filename2 = 'p_data_TEST2.mat';

scoreTEST2 = 0;
%here, we use 2 for loops, the first iterates through a number of blocks
%adn choses one, the second is assigned to iterate through the trial
%number. We select indices for both that are used to access an image from
%the first task.
%The code enters a conditional statement (if rand() < 0.5) where it generates a random number using rand() and compares it to 0.5. 
% If the condition is met, a random index is chosen from allPieCharts array, and the corresponding pie chart image data, name, and probability
% are assigned to image2, image1Name, and probability1, respectively. If the condition is not met, the code follows the else branch,
% similar to how it handled image1.

for block = 1:2
    for trial = 1:blockSizeSecondPartTEST
        selectedBlockIndicesTEST2 = randperm(3, 1);
        selectedIndicesTEST2 = randperm(2); 
        image1NameTEST2 = selectedImagesFromFirstPartTEST(selectedBlockIndicesTEST2, selectedIndicesTEST2(1));               % extracts the name of the first image based on the random indices for block and trial form task1
        image1IndexTEST2 = find(strcmp(allImageNamesTEST, image1NameTEST2));                                                %searches for index of image1NameTEST within the allImageNamesTEST
        image1TEST2 = cell2mat(allImagesTEST(image1IndexTEST2));                                                            %converts the image data from a cell array (allImagesTEST) to a regular matrix.
        probability1TEST2 = selectedProbabilitiesFromFirstPartTEST(selectedBlockIndicesTEST2, selectedIndicesTEST2(1));      %assigns a probability value associated with the first image, based on the random indices selected

        if rand() < 0.5                                                                                                      %condtitional statement for deciding the side to present the image 
            selectedPieChartIndexTEST2 = randi(numel(allPieChartProbabilitiesTEST2));
            probabilityPieTEST2 = allPieChartProbabilitiesTEST2(selectedPieChartIndexTEST2);
            piechartTypeTEST2 = randperm(4, 1);                                                                              %selects a random index from the pie chart data array.
            image2TEST2 = generate_piechart(probabilityPieTEST2, piechartTypeTEST2);                                            % allPieChartsTEST{selectedPieChartIndexTEST};                                                         %The selected pie chart's image data is extracted from the allPieChartsTEST array using the index.
                                                                                                                             % pie-chart probability is extracted given the corresponding index
            image2TEST2 = imresize(image2TEST2, imageSize);
            image2NameTEST2 = ['Pie' num2str(piechartTypeTEST2)];
        else
            image2NameTEST2 = selectedImagesFromFirstPartTEST(selectedBlockIndicesTEST2, selectedIndicesTEST2(2));           %if rand() > 0.5, the image from the first task is retrieved using the block and trial index rarndomly selected above
            image2IndexTEST2 = find(strcmp(allImageNamesTEST, image2NameTEST2));                                            % the image data is accessed (using indexing from above) in the allimage array.
            image2TEST2 = cell2mat(allImagesTEST(image2IndexTEST2));                                                        % image data is converted to matrix format
            probability2TEST2 = selectedProbabilitiesFromFirstPartTEST(selectedBlockIndicesTEST2, selectedIndicesTEST2(2));  % corresponding probability is assigned to the image
        end

        isNewImageTEST2 = randi(2) == 1;  

        if rand() < 0.5
            textureLeftTEST2 = Screen('MakeTexture', window, image1TEST2);
            textureRightTEST2 = Screen('MakeTexture', window, image2TEST2);
            probabilityLeftTEST2 = probability1TEST2;
            probabilityRightTEST2 = probability2TEST2;
        else
            textureLeftTEST2 = Screen('MakeTexture', window, image2TEST2);
            textureRightTEST2 = Screen('MakeTexture', window, image1TEST2);
            probabilityLeftTEST2 = probability2TEST2;
            probabilityRightTEST2 = probability1TEST2;
        end


        selectedLeftProbabilitiesTEST2((block-1)*blockSizeSecondPartTEST + trial) = probabilityLeftTEST2;
        selectedRightProbabilitiesTEST2((block-1)*blockSizeSecondPartTEST + trial) = probabilityRightTEST2;

        display(probabilityLeftTEST2);
        display(probabilityRightTEST2);
        
        vbl = Screen('Flip', window);
        Screen('DrawTexture', window, textureLeftTEST2, [], [xCenter-separation/2-imageSize(1) yCenter-imageSize(2)/2 xCenter-separation/2 yCenter+imageSize(2)/2], 0);
        Screen('DrawTexture', window, textureRightTEST2, [], [xCenter+separation/2 yCenter-imageSize(2)/2 xCenter+separation/2+imageSize(1) yCenter+imageSize(2)/2], 0);

        vbl = Screen('Flip', window, vbl + (1 - 0.5) * ifi);
        tic();                                                                                                            % here, we start mesuring elapsed time again, we also store left and right click in designated arrays to analyse participant's choice
        selectedImageTEST2 = '';
        while isempty(selectedImageTEST2)
            [~, keyCode, ~] = KbWait;
            keyPressed = KbName(find(keyCode));

            if strcmp(keyPressed, 'a')
                selectedImageTEST2 = 'left';                                                                               % assigning left and right names corresponding to 'a' and 'k'
                clicksArrayTEST2((block-1)*blockSizeSecondPartTEST + trial) = 1;                                          % Store left click (1) in the array
            elseif strcmp(keyPressed, 'k')
                selectedImageTEST2 = 'right';                                                                              % assigning left and right names corresponding to 'a' and 'k'
                clicksArrayTEST2((block-1)*blockSizeSecondPartTEST + trial) = 0;                                          % Store right click (0) in the array
            end
        end    
        elapsedTimeTEST2((block-1)*blockSizeSecondPartTEST + trial) = toc();                                              % Measure the elapsed time for each trial

        if strcmp(selectedImageTEST2, 'left')
            leftimTEST2((block-1)*blockSizeSecondPartTEST + trial) = {image1NameTEST2};
            rightimTEST2((block-1)*blockSizeSecondPartTEST + trial) = {image2NameTEST2};
            Screen('DrawTexture', window, textureLeftTEST2, [], [xCenter-separation/2-imageSize(1) yCenter-imageSize(2)/2 xCenter-separation/2 yCenter+imageSize(2)/2], 0);
            Screen('FrameRect', window, [0, 255, 0], [xCenter-separation/2-imageSize(1)-10 yCenter-imageSize(2)/2-10 xCenter-separation/2+10 yCenter+imageSize(2)/2+10], 3);
            Screen('DrawTexture', window, textureRightTEST2, [], [xCenter+separation/2 yCenter-imageSize(2)/2 xCenter+separation/2+imageSize(1) yCenter+imageSize(2)/2], 0);
            
            if probabilityLeftTEST2 > probabilityRightTEST2
                scoreTEST2 = scoreTEST2 + 1;                                                                              % Participant wins if they click the left image (higher probability)
                outcomeArrayTEST2((block-1)*blockSizeSecondPartTEST + trial) = 1; 
                utility_ArrayTEST2((block-1)*blockSizeSecondPartTEST + trial) = 1;             % Participant's win is added to the outcomeArray2TEST
            else 
                scoreTEST2 = scoreTEST2 - 1;                                                                              % Participant loses if they click the right image (lower probability)
                outcomeArrayTEST2((block-1)*blockSizeSecondPartTEST + trial) = 0;
                utility_ArrayTEST2((block-1)*blockSizeSecondPartTEST + trial) = 0;
                % Participant loses if they click the right image (lower probability)
            end

        elseif strcmp(selectedImageTEST2, 'right')
            leftimTEST2((block-1)*blockSizeSecondPartTEST + trial) = {image2NameTEST2};
            rightimTEST2((block-1)*blockSizeSecondPartTEST + trial) = {image1NameTEST2};

            Screen('DrawTexture', window, textureRightTEST2, [], [xCenter+separation/2 yCenter-imageSize(2)/2 xCenter+separation/2+imageSize(1) yCenter+imageSize(2)/2], 0);
            Screen('FrameRect', window, [0, 255, 0], [xCenter+separation/2-10 yCenter-imageSize(2)/2-10 xCenter+separation/2+imageSize(1)+10 yCenter+imageSize(2)/2+10], 3);
            Screen('DrawTexture', window, textureLeftTEST2, [], [xCenter-separation/2-imageSize(1) yCenter-imageSize(2)/2 xCenter-separation/2 yCenter+imageSize(2)/2], 0);
            
            if probabilityRightTEST2 > probabilityLeftTEST2
                scoreTEST2 = scoreTEST2 + 1;                                                                             % Participant wins if they click the right image (higher probability)
                outcomeArrayTEST2((block-1)*blockSizeSecondPartTEST + trial) = 1;  
                utility_ArrayTEST2((block-1)*blockSizeSecondPartTEST + trial) = 1;                                       % Participant wins if they click the right image (higher probability)
            else
                scoreTEST2 = scoreTEST2 - 1;                                                                             % Participant loses if they click the left image (lower probability)
                outcomeArrayTEST2((block-1)*blockSizeSecondPartTEST + trial) = 0;
                utility_ArrayTEST2((block-1)*blockSizeSecondPartTEST + trial) = 0;                                        % Participant loses if they click the left image (lower probability)
            end 
        end
        scoreArraySecondPartTEST((block-1)*blockSizeSecondPartTEST + trial) = scoreTEST2;
        vbl = Screen('Flip', window);
        display(scoreTEST2);
        WaitSecs(blankDuration);

        Screen('FillRect', window, white);
        Screen('Flip', window);

        WaitSecs(blankDuration);   
    end
end

% Display the final score
finalScoreMessage = sprintf('Overall you won %d points! Congrats!', scoreTEST2);
Screen('TextSize', window, 22);
DrawFormattedText(window, finalScoreMessage, 'center', 'center', black);
Screen('Flip', window);
KbStrokeWait;

endMessage = 'Now, we start with the third part!';
Screen('TextSize', window, 22);
DrawFormattedText(window, endMessage, 'center', 'center', black);
Screen('Flip', window);
KbStrokeWait;

save(filename2, 'scoreArraySecondPartTEST', 'clicksArrayTEST2', 'elapsedTimeTEST2', 'selectedLeftProbabilitiesTEST2', 'selectedRightProbabilitiesTEST2', 'outcomeArrayTEST2', 'leftimTEST2', 'rightimTEST2', 'utility_ArrayTEST2');

% This here is an important varaible as we need to bea able to access the
% same images used in the first and secodn task for the 3. slider task.
%this line extracts values from the selectedImagesFromFirstPart array and 
% puts them into a single column format, the unique function then returns only the unique values

selectedImagesFromPartsTEST = unique(selectedImagesFromFirstPartTEST(:));     

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%  Testing Phase: Slider - Task  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Slider task 
% Instructions

black = BlackIndex(screenNumber);
white = WhiteIndex(screenNumber);
grey = white / 2;    
line43 = 'TRAINING: Instructions for the third test:';
line44= '\n\n  In each round of the third test you will be presented with the symbols and pie-charts you met in the first and second test.';
line45 = '\n\n\n  This is now the occasion where we test your knowledge of each symbol average outcome.';
line46 = '\n\n\n   1.You will be asked to indicate (in percentage), what are the odds that a given symbol or pie-chart makes you win a point (+1 = + 0.002p).';
line47 = '\n\n\n   2.There will be a scale below the slider through which you can indicate the confidence you have in your estimation of the above probability:'; 
line48 = '\n\n\n   1 means you are not at all sure what the probability is and 5 means you are absolutely sure,';
line49 = '\n\n\n   You can move the sliders on screen with the mouse cursor';
line50 = '\n\n\n Please press the space bar to continue.';
Screen('TextSize', window, 18);
DrawFormattedText(window, [line43 line44 line45 line46 line47 line48 line49 line50],...
    'center', screenYpixels * 0.25, black);
Screen('Flip', window);
KbStrokeWait;

%%%%%%%%% General Parameters %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
textSize = 18; 
sliderLineWidth = 10;
dim = screenYpixels / 50;
hDim = dim / 2;
smallTextSize = 15;
scaleLineWidth = 6;
% Define colors
red = [black 0 0];
green = [0 black 0];
blue = [0 0 black];
yellowTrans = [black black black 0.5]; 

%%%%%%%% Slider 1 Parameters %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

sliderLengthPix = screenYpixels / 1.5;
sliderHLengthPix = sliderLengthPix / 2;
leftEnd = [xCenter - sliderHLengthPix yCenter + sliderHLengthPix * 0.6];
rightEnd = [xCenter + sliderHLengthPix yCenter + sliderHLengthPix * 0.6];
sliderLineCoords = [leftEnd' rightEnd'];
sliderLabels = {'0%', '100%'};
SetMouse(xCenter, yCenter, window);
offsetSet = 0;
% Initialize centeredRect for Slider 1 to a random position
baseRect = [0 0 dim dim]; 
sx = xCenter + (rand * 2 - 1) * sliderHLengthPix;
centeredRect = CenterRectOnPointd(baseRect, sx, yCenter + sliderHLengthPix * 0.6);
aboveSliderPosY2 = yCenter + sliderHLengthPix * 0.4; %  value for aboveSliderPosY + textPixGap????
textPixGap = 70;
textPixGap2 = 60;
slider1LeftBound = xCenter - sliderHLengthPix;
slider1RightBound = xCenter + sliderHLengthPix;
slider1TopBound = yCenter + sliderHLengthPix * 0.6 - dim / 2;
slider1BottomBound = yCenter + sliderHLengthPix * 0.6 + dim / 2;

%%%%%%%% Slider 2 Parameters %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 

leftLabel = 'very uncertain';
rightLabel = 'very confident';
bottomY = screenYpixels * 0.8; % position of Slider 2 (lower 20 percent of the screen)
textPosY = bottomY - hDim - textPixGap;
scaleLengthPix = screenYpixels / 1.5;
scaleHLengthPix = scaleLengthPix / 2;
leftEnd2 = [xCenter - scaleHLengthPix, bottomY]; 
rightEnd2 = [xCenter + scaleHLengthPix, bottomY]; 
scaleLineCoords2 = [leftEnd2', rightEnd2'];
numScalePoints2 = 5;
xPosScalePoints2 = linspace(xCenter - scaleHLengthPix, xCenter + scaleHLengthPix, numScalePoints2);
numScalePoints2Offset = 0; 
yPosScalePoints2 = repmat(bottomY + numScalePoints2Offset, 1, numScalePoints2); 
xyScalePoints2 = [xPosScalePoints2; yPosScalePoints2];
leftTextPosX2 = xCenter - scaleHLengthPix - hDim - textPixGap2 - textSize * 30;
rightTextPosX2 = xCenter + scaleHLengthPix + hDim + textPixGap2 + textSize * 20;
textPosY2 = bottomY + hDim + textPixGap; 
numShiftUpPix = 30; 
xNumText2 = xPosScalePoints2 - hDim;
yNumText2 = repmat(bottomY - numShiftUpPix, 1, numScalePoints2); 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

numTrialsSliderTEST3 = 4;
SliderResponsesTEST3 = cell(numTrialsSliderTEST3, 1);
selectedImageNameSliderTEST3 = cell(numTrialsSliderTEST3, 1);
confidenceLevelsTEST3 = zeros(numTrialsSliderTEST3, 1); 
thisNumSliderTEST3 = 1; 

for trial = 1:numTrialsSliderTEST3
    selectedImageIdxSliderTEST3 = randi(numel(selectedImagesFromPartsTEST));                                               %  random index between 1 and the number of elements in the selectedImagesFromPartsTEST cell array, index is used to randomly select an image name.
    selectedImageNameSliderTEST3{trial} = selectedImagesFromPartsTEST{selectedImageIdxSliderTEST3};                         % Assigns the selected image name to the selectedImageNameSliderTEST array at the current trial index.
    imageIndexSliderTEST3 = find(strcmp(allImageNamesTEST, selectedImageNameSliderTEST3{trial}));                           % Searches for the index of the selected image name within the allImageNamesTEST cell array.
    selectedImageSliderTEST3 = allImagesTEST{imageIndexSliderTEST3};                                                        % Retrieves the selected image data from the allImagesTEST cell array based on the found index.
    selectedImagesFromPartsTEST(selectedImageIdxSliderTEST3) = [];                                                            % reomves it from the array to avoid repetition of samw image

    [imageHeight, imageWidth, ~] = size(selectedImageSliderTEST3);
    imageRect = [0, 0, imageWidth, imageHeight];
    imageDestinationRect = CenterRectOnPointd(imageRect, xCenter, yCenter - imageHeight/8);                               % imageHeight/8 will move the image slightly up to fit the slider task outline

    currentPercentageTEST = -1;
    selectedConfidenceTEST = 0;

    while true
        Screen('DrawTexture', window, Screen('MakeTexture', window, selectedImageSliderTEST3), [], imageDestinationRect);
        Screen('DrawTexture', window, Screen('MakeTexture', window, selectedImageSliderTEST3), [], imageDestinationRect);
        [mx, my, buttons] = GetMouse(window);

        if mx >= slider1LeftBound && mx <= slider1RightBound && my >= slider1TopBound && my <= slider1BottomBound         % condition checks if the mouse cursor is within the bounds, the region where the slider can be interacted with.
             % Draw Slider 1
           sx = mx;
           if sx > xCenter + sliderHLengthPix
              sx = xCenter + sliderHLengthPix;
           elseif sx < xCenter - sliderHLengthPix
              sx = xCenter - sliderHLengthPix;
           end
           centeredRect = CenterRectOnPointd(baseRect, sx, yCenter + sliderHLengthPix * 0.6);
        end
        Screen('DrawLines', window, sliderLineCoords, sliderLineWidth, black);
        Screen('FillRect', window, yellowTrans, centeredRect);
        Screen('FrameRect', window, green, centeredRect);

       % labels for '0%' and '100%'
       leftTextPosX2 = xCenter - scaleHLengthPix - hDim - textPixGap2 - textSize * 2;
       rightTextPosX2 = xCenter + scaleHLengthPix + hDim + textPixGap2 - textSize * 3;

       DrawFormattedText(window, sliderLabels{1}, leftTextPosX2, aboveSliderPosY2, blue);
       DrawFormattedText(window, sliderLabels{2}, rightTextPosX2, aboveSliderPosY2, red);
       DrawFormattedText(window, 'What are the odds that this symbol yields a +1?', 'center', screenYpixels * 0.25, black);
       currentPercentageTEST = round((sx - (xCenter - sliderHLengthPix)) / sliderLengthPix * 100);
       DrawFormattedText(window, [num2str(currentPercentageTEST) '%'], 'center', aboveSliderPosY2, black);
       
       % Draw Slider 2                                                                          % Get mouse position relative to the window
       inCircles = sqrt((xPosScalePoints2 - mx).^2 + (yPosScalePoints2 - my).^2) < hDim;
       weInCircle = sum(inCircles) > 0;
       if weInCircle == 1
           [~, posCircle] = max(inCircles);
           coordsCircle = xyScalePoints2(:, posCircle);
           selectedConfidenceTEST = posCircle;                                                                               % Store the selected confidence level
       end
       Screen('DrawLines', window, scaleLineCoords2, scaleLineWidth, grey);

    % labels for 'very certain' and 'very uncertain'
       DrawFormattedText(window, leftLabel, xCenter - scaleHLengthPix, textPosY2, black);
       DrawFormattedText(window, rightLabel, xCenter + scaleHLengthPix - textSize * 10, textPosY2, black);

       if selectedConfidenceTEST ~= 0
          Screen('FrameOval', window, grey, [coordsCircle - dim * 0.8; coordsCircle + dim * 0.8], 2);
       end
       for i = 1:numScalePoints2
           Screen('FillOval', window, black, [xPosScalePoints2(i) - hDim, yPosScalePoints2(i) - hDim, xPosScalePoints2(i) + hDim, yPosScalePoints2(i) + hDim]);
       end
       Screen('TextSize', window, smallTextSize);
       for thisNumSliderTEST3 = 1:numScalePoints2
           DrawFormattedText(window, num2str(thisNumSliderTEST3), xNumText2(thisNumSliderTEST3), yNumText2(thisNumSliderTEST3), black);
       end
       Screen('TextSize', window, textSize);
       Screen('Flip', window);

         % is space bar pressed
        [keyIsDown, ~, keyCode] = KbCheck(-1);
        if keyIsDown && keyCode(KbName('space')) & currentPercentageTEST ~= -1 & selectedConfidenceTEST ~= 0
            break
        end
    end
    % Update confidence level for the current trial
    confidenceLevelsTEST3(trial) = selectedConfidenceTEST;

    % record the response
    SliderResponsesTEST3{trial}.imageName = selectedImageNameSliderTEST3{trial};
    SliderResponsesTEST3{trial}.sliderValue = currentPercentageTEST;
    SliderResponsesTEST3{trial}.confidenceLevel = confidenceLevelsTEST3(trial);

    WaitSecs(blankDuration); 
end

% Save the slider task responses to a MAT file
filenameSliderTEST3 = 'SliderResponsesTEST3.mat';
save(filenameSliderTEST3, 'SliderResponsesTEST3');
% sca;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%     % %      %     %    %   %   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%    % % %    %%%    %    % % %   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%   %     %  %   %   %    %   %   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%THis phase covers creating code for the main task, first we will recreate
%the learning phase, now the blocks are of length 30. - I'll keep them
%shorter for now

black = BlackIndex(screenNumber);
white = WhiteIndex(screenNumber);
% grey = white / 2;    
textSize = 18; 
sliderLineWidth = 10;
dim = screenYpixels / 50;
hDim = dim / 2;
smallTextSize = 15;
scaleLineWidth = 6;
% Define colors
red = [black 0 0];
green = [0 black 0];
blue = [0 0 black];
yellowTrans = [black black black 0.5]; 

% Pie-Charts images
% EQ13 = imread("1_3_EQ.png");
% EQ23 = imread("2_3_EQ.png");
% EQ33 = imread("3_3_EQ.png");
% EQ43 = imread("4_3_EQ.png");
% EQ53 = imread("5_3_EQ.png");
% EQ63 = imread("6_3_EQ.png");
% EQ73 = imread("7_3_EQ.png");
% 
% DI13 = imread("1_3_DI.png");
% DI23 = imread("2_3_DI.png");
% DI33 = imread("3_3_DI.png");
% DI43 = imread("4_3_DI.png");
% DI53 = imread("5_3_DI.png");
% DI63 = imread("6_3_DI.png");
% DI73 = imread("7_3_DI.png");
% 
% EQ16 = imread("1_6_EQ.png");
% EQ26 = imread("2_6_EQ.png");
% EQ36 = imread("3_6_EQ.png");
% EQ46 = imread("4_6_EQ.png");
% EQ56 = imread("5_6_EQ.png");
% EQ66 = imread("6_6_EQ.png");
% EQ76 = imread("7_6_EQ.png");
% 
% DI16 = imread("1_6_DI.png");
% DI26 = imread("2_6_DI.png");
% DI36 = imread("3_6_DI.png");
% DI46 = imread("4_6_DI.png");
% DI56 = imread("5_6_DI.png");
% DI66 = imread("6_6_DI.png");
% DI76 = imread("7_6_DI.png");
% 
% imageSize = [268, 268];
% EQ13 = imresize(EQ13, imageSize);
% EQ23 = imresize(EQ23, imageSize);
% EQ33 = imresize(EQ33, imageSize);
% EQ43 = imresize(EQ43, imageSize);
% EQ53 = imresize(EQ53, imageSize);
% EQ63 = imresize(EQ63, imageSize);
% EQ73 = imresize(EQ73, imageSize);
% 
% imageSize = [268, 268];
% DI13 = imresize(DI13, imageSize);
% DI23 = imresize(DI23, imageSize);
% DI33 = imresize(DI33, imageSize);
% DI43 = imresize(DI43, imageSize);
% DI53 = imresize(DI53, imageSize);
% DI63 = imresize(DI63, imageSize);
% DI73 = imresize(DI73, imageSize);
% 
% imageSize = [268, 268];
% EQ16 = imresize(EQ16, imageSize);
% EQ26 = imresize(EQ26, imageSize);
% EQ36 = imresize(EQ36, imageSize);
% EQ46 = imresize(EQ46, imageSize);
% EQ56 = imresize(EQ56, imageSize);
% EQ66 = imresize(EQ66, imageSize);
% EQ76 = imresize(EQ76, imageSize);
% 
% imageSize = [268, 268];
% DI16 = imresize(DI16, imageSize);
% DI26 = imresize(DI26, imageSize);
% DI36 = imresize(DI36, imageSize);
% DI46 = imresize(DI46, imageSize);
% DI56 = imresize(DI56, imageSize);
% DI66 = imresize(DI56, imageSize);
% DI76 = imresize(DI76, imageSize);
% 
% allPieChartsEXP = {EQ13, EQ23, EQ33, EQ43, EQ53, EQ63, EQ73,   DI13, DI23, DI33, DI43, DI53, DI63, DI73,   EQ16, EQ26, EQ36, EQ46, EQ56, EQ66, EQ76,   DI16, DI26, DI36, DI46, DI56, DI66, DI76};
% allPieChartProbabilitiesEXP = [0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8,   0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8,   0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8,    0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8];
% allPieChartsNamesEXP = {'EQ13', 'EQ23', 'EQ33', 'EQ43', 'EQ53', 'EQ63', 'EQ73', 'DI13', 'DI23', 'DI33', 'DI43', 'DI53', 'DI63', 'DI73', 'EQ16', 'EQ26', 'EQ36', 'EQ46', 'EQ56', 'EQ66', 'EQ76', 'DI16', 'DI26', 'DI36', 'DI46', 'DI56', 'DI66', 'DI76'};
% allPieChartProbabilitiesNamesEXP = [0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8,   0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8,   0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8,    0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8];

Fire = imread("Fire.png");
Equal = imread("Equal.png");
Neg = imread("-1.png");
Pos = imread("1.png");
Arrow = imread("Experiment_Icons_Arrow.png");
Circle1 = imread("Experiment_Icons_Circle.png");
Intersection = imread("Experiment_Icons_Intersection.png");
Menue = imread("Experiment_Icons_Menu.png");

imageSize = [268, 268];
Fire = imresize(Fire, imageSize);
Equal = imresize(Equal, imageSize);
Neg = imresize(Neg, imageSize);
Pos = imresize(Pos, imageSize);
Arrow = imresize(Arrow, imageSize);
Circle1 = imresize(Circle1, imageSize);
Intersection = imresize(Intersection, imageSize);
Menue = imresize(Menue, imageSize);

allImagesEXP = {Fire, Equal, Arrow, Circle1, Intersection, Menue};
allImageNamesEXP = {'Fire', 'Equal', 'Arrow', 'Circle1', 'Intersection', 'Menue'};

% probability arrays
I = [1/8, 7/8];
J = [2/8, 6/8];
K = [3/8, 5/8];
L = [4/8, 4/8];
M = [5/8, 3/8];
N = [6/8, 2/8];
O = [7/8, 1/8];

allProbabilityArraysEXP = {I, J, K, L, M, N, O,};
allProbabilityNamesEXP = {'I', 'J', 'K', 'L', 'M', 'N', 'O'};

% separation between images
separation = 300; 
blockSize1and2EXP = 10;
blockSize3EXP = 10;

startMessage = 'Press any key to start the trials.';
Screen('TextSize', window, 18);
DrawFormattedText(window, startMessage, 'center', 'center', black);
Screen('Flip', window);
KbStrokeWait;

line51 = 'Welcome to this experiment. This experiment is composed of 3 main steps:';
line52 = '\n\n 1)Training Phase: You will get introduced to the 3 different tests.';
line53 = '\n\n\n 2) 1. Phase of the experiment: You will play a longer version of the 3 different tests.';
line54 = '\n\n\n 3)	2. Phase: We will ask you how confident you are about your choices.';
line55 = '\n\n\n In addition to the fixed compensation of £16 you will be endowed with an additional £2,';
line56 = '\n\n\n depending on your choices you can either lose or double this endowment!';
line57 = '\n\n\nPlease press the space bar to continue';
Screen('TextSize', window, 18);
DrawFormattedText(window, [line51 line52 line53 line54 line55 line56 line57],...
    'center', screenYpixels * 0.25, black);
Screen('Flip', window);
KbStrokeWait;

line58 = 'REAL EXPERIMENT: Instructions for the experimental test:';
line59 = '\n\n In each round, you have to choose between one of two symbols displayed on either side of the screen.';
line60 = '\n\n\n To select the left symbol, use the "a" key; to select the right symbol, use the "k" key.';
line61 = '\n\n\n After a choice, you can win/lose the following outcomes:';
line62 = '\n\n\n 1 point = 0.002 pence'; 
line63 = '\n\n\n -1 point = -0.002 pence';
line64 = '\n\n\n Remember, in total, you can win up to £4 additional money.';
line65 = '\n\n\n Please note that only the outcome of your choice will be considered in the final payoff.';
line66 = '\n\n\n Please also note that the points won during the Experiment will count towards your payoff.';
line67 = '\n\n\n Please note that only the outcome of your choice will be considered in the final payoff.';
line68 = '\n\n\n Please press the space bar to continue.';
Screen('TextSize', window, 18);
DrawFormattedText(window, [line58 line59 line60 line61 line62 line63 line64 line65 line66 line67 line68],...
    'center', screenYpixels * 0.25, black);
Screen('Flip', window);
KbStrokeWait;

selectedImagesFromEXP = cell(3, 2);
selectedProbabilitiesFromEXP = zeros(3, 2);
elapsedTimeEXP = zeros(2 * blockSize1and2EXP + blockSize3EXP, 1);
leftimEXP = cell(3, 1);
rightimEXP = cell(3, 1);
clicksArray1EXP = zeros(2 * blockSize1and2EXP + blockSize3EXP, 1);
leftOutcomesEXP = zeros(1, 2 * blockSize1and2EXP + blockSize3EXP);
rightOutcomesEXP = zeros(1, 2 * blockSize1and2EXP + blockSize3EXP);
numTrialsEXP = 2 * blockSize1and2EXP + blockSize3EXP;
scoreArrayEXP = zeros(numTrialsEXP, 1);
outcomeArrayEXP = zeros(numTrialsEXP, 1);
leftProbabilitiesFirstPartEXP = zeros(3, 1);
rightProbabilitiesFirstPartEXP = zeros(3, 1);
utility_ArrayEXP1 = zeros(numTrialsEXP, 1);


dataCellEXP = {
    selectedImagesFromEXP,
    selectedProbabilitiesFromEXP,
    elapsedTimeEXP,
    leftimEXP,
    rightimEXP,
    leftOutcomesEXP,
    rightOutcomesEXP,
    numTrialsEXP,
    scoreArrayEXP,
    clicksArray1EXP,
    outcomeArrayEXP,
    leftProbabilitiesFirstPartEXP,
    rightProbabilitiesFirstPartEXP,
    utility_ArrayEXP1
    
};

filenameEXP = 'participant_dataEXP1.mat';

scoreEXP = 0;
trialNumEXP = 0;
selectedImagesFromFirstPartEXP = cell(3, 2);
selectedProbabilitiesFromFirstPartEXP = zeros(3, 2);

% Shuffle the images for this block
shuffledImageIndices = randperm(numel(allImagesEXP));
shuffledImageNamesEXP = allImageNamesEXP(shuffledImageIndices);
shuffledProbabilityArrays = Shuffle(allProbabilityArraysEXP);


for block = 1:3
   repeats = true;
   
    while repeats
        selectedIndicesEXP = randperm(numel(allImagesEXP), 2);
        name1EXP = allImageNamesEXP(selectedIndicesEXP(1));
        name2EXP = allImageNamesEXP(selectedIndicesEXP(2));
        if ~ any(any(strcmp(selectedImagesFromEXP, name1EXP))) & ~ any(any(strcmp(selectedImagesFromEXP, name2EXP)))
            repeats = false;
        end
    end

    % selectedIndices = randperm(numel(allImages), 2);
    image1EXP = allImagesEXP{selectedIndicesEXP(1)};
    image2EXP = allImagesEXP{selectedIndicesEXP(2)};

    selectedImagesFromEXP(block, 1) = allImageNamesEXP(selectedIndicesEXP(1));
    selectedImagesFromEXP(block, 2) = allImageNamesEXP(selectedIndicesEXP(2));

    texture1EXP = Screen('MakeTexture', window, image1EXP);
    texture2EXP = Screen('MakeTexture', window, image2EXP);

    % Randomly select the probability array
    chosenProbabilityIndexEXP = randi(numel(allProbabilityArraysEXP));
%     chosenProbabilityArrayEXP = cell2mat(allProbabilityArraysEXP(chosenProbabilityIndexEXP));
%     selectedProbabilitiesFromEXP(block, 1) = chosenProbabilityArrayEXP(1);
%     selectedProbabilitiesFromEXP(block, 2) = chosenProbabilityArrayEXP(2);

    chosenProbabilityArrayEXP = shuffledProbabilityArrays{block};
    selectedProbabilitiesFromEXP(block, 1) = chosenProbabilityArrayEXP(1);
    selectedProbabilitiesFromEXP(block, 2) = chosenProbabilityArrayEXP(2);

    if block == 3
        trialsInBlock = blockSize3EXP;
    else
        trialsInBlock = blockSize1and2EXP;
    end

    outcomes1EXP = Shuffle(horzcat(-1 * ones(1, int32(trialsInBlock * (1 - chosenProbabilityArrayEXP(1)))), ones(1, int32(trialsInBlock * chosenProbabilityArrayEXP(1)))));
    outcomes2EXP = Shuffle(horzcat(-1 * ones(1, int32(trialsInBlock * (1 - chosenProbabilityArrayEXP(2)))), ones(1, int32(trialsInBlock * chosenProbabilityArrayEXP(2)))));


    for trial = 1:trialsInBlock
        trialNumEXP = trialNumEXP + 1;
        randomPositionsEXP = randperm(2);
        position1EXP = randomPositionsEXP(1);
        position2EXP = randomPositionsEXP(2);

       if position1EXP == 1
        leftProbabilityEXP = chosenProbabilityArrayEXP(1);
        rightProbabilityEXP = chosenProbabilityArrayEXP(2);
       else
        leftProbabilityEXP = chosenProbabilityArrayEXP(2);
        rightProbabilityEXP = chosenProbabilityArrayEXP(1);
       end



        vbl = Screen('Flip', window);
        if position1EXP == 1
            Screen('DrawTexture', window, texture1EXP, [], [xCenter-separation/2-imageSize(1) yCenter-imageSize(2)/2 xCenter-separation/2 yCenter+imageSize(2)/2], 0);
            Screen('DrawTexture', window, texture2EXP, [], [xCenter+separation/2 yCenter-imageSize(2)/2 xCenter+separation/2+imageSize(1) yCenter+imageSize(2)/2], 0);
            outcome1EXP = outcomes1EXP(trial);
            outcome2EXP = outcomes2EXP(trial);
            leftimEXP{trialNumEXP} = selectedImagesFromEXP{block, 1};
            rightimEXP{trialNumEXP} = selectedImagesFromEXP{block, 2};

        elseif position2EXP == 1
            Screen('DrawTexture', window, texture1EXP, [], [xCenter+separation/2 yCenter-imageSize(2)/2 xCenter+separation/2+imageSize(1) yCenter+imageSize(2)/2], 0);
            Screen('DrawTexture', window, texture2EXP, [], [xCenter-separation/2-imageSize(1) yCenter-imageSize(2)/2 xCenter-separation/2 yCenter+imageSize(2)/2], 0);
            outcome1EXP = outcomes2EXP(trial);
            outcome2EXP = outcomes1EXP(trial);
            leftimEXP{trialNumEXP} = selectedImagesFromEXP{block, 2};
            rightimEXP{trialNumEXP} = selectedImagesFromEXP{block, 1};
        end

        vbl = Screen('Flip', window, vbl + (1 - 0.5) * ifi);
        tic();
        % Wait for key press to chose image
        selectedImageEXP = '';
        while isempty(selectedImageEXP)
            [~, keyCode, ~] = KbWait;
            keyPressed = KbName(find(keyCode));

            if strcmp(keyPressed, 'a')
                selectedImageEXP = 'left';
                %leftClick(trialNum) = 1; 
                clicksArray1EXP(trialNumEXP) = 1;    %stores left click (1) in the array
                %scoreEXP = scoreEXP + outcome1EXP;
                leftOutcomesEXP(trialNumEXP) = outcome1EXP;
                rightOutcomesEXP(trialNumEXP) = outcome2EXP;
                %scoreArrayEXP(trialNumEXP) =
                %scoreEXP;        

            elseif strcmp(keyPressed, 'k')
                selectedImageEXP = 'right';
                %rightClick(trialNum) = 1;
                clicksArray1EXP(trialNumEXP) = 0;   %stores right click (2) in the array
                %scoreEXP = scoreEXP + outcome2EXP;
                leftOutcomesEXP(trialNumEXP) = outcome2EXP;
                rightOutcomesEXP(trialNumEXP) = outcome1EXP;
                %scoreArrayEXP(trialNumEXP) = scoreEXP;

            end
        end
        elapsedTimeEXP(trialNumEXP) = toc();

        display(scoreEXP);

        % rectangle outline
        if strcmp(selectedImageEXP, 'left')
            if position1EXP == 1
                Screen('DrawTexture', window, texture1EXP, [], [xCenter-separation/2-imageSize(1) yCenter-imageSize(2)/2 xCenter-separation/2 yCenter+imageSize(2)/2], 0);
                Screen('FrameRect', window, [0, 255, 0], [xCenter-separation/2-imageSize(1)-10 yCenter-imageSize(2)/2-10 xCenter-separation/2+10 yCenter+imageSize(2)/2+10], 3);
                Screen('DrawTexture', window, texture2EXP, [], [xCenter+separation/2 yCenter-imageSize(2)/2 xCenter+separation/2+imageSize(1) yCenter+imageSize(2)/2], 0);
            else
                Screen('DrawTexture', window, texture2EXP, [], [xCenter-separation/2-imageSize(1) yCenter-imageSize(2)/2 xCenter-separation/2 yCenter+imageSize(2)/2], 0);
                Screen('FrameRect', window, [0, 255, 0], [xCenter-separation/2-imageSize(1)-10 yCenter-imageSize(2)/2-10 xCenter-separation/2+10 yCenter+imageSize(2)/2+10], 3);
                Screen('DrawTexture', window, texture1EXP, [], [xCenter+separation/2 yCenter-imageSize(2)/2 xCenter+separation/2+imageSize(1) yCenter+imageSize(2)/2], 0);
            end
        elseif strcmp(selectedImageEXP, 'right')
            if position1EXP == 2
                Screen('DrawTexture', window, texture1EXP, [], [xCenter+separation/2 yCenter-imageSize(2)/2 xCenter+separation/2+imageSize(1) yCenter+imageSize(2)/2], 0);
                Screen('FrameRect', window, [0, 255, 0], [xCenter+separation/2-10 yCenter-imageSize(2)/2-10 xCenter+separation/2+imageSize(1)+10 yCenter+imageSize(2)/2+10], 3);
                Screen('DrawTexture', window, texture2EXP, [], [xCenter-separation/2-imageSize(1) yCenter-imageSize(2)/2 xCenter-separation/2 yCenter+imageSize(2)/2], 0);
            else
                Screen('DrawTexture', window, texture2EXP, [], [xCenter+separation/2 yCenter-imageSize(2)/2 xCenter+separation/2+imageSize(1) yCenter+imageSize(2)/2], 0);
                Screen('FrameRect', window, [0, 255, 0], [xCenter+separation/2-10 yCenter-imageSize(2)/2-10 xCenter+separation/2+imageSize(1)+10 yCenter+imageSize(2)/2+10], 3);
                Screen('DrawTexture', window, texture1EXP, [], [xCenter-separation/2-imageSize(1) yCenter-imageSize(2)/2 xCenter-separation/2 yCenter+imageSize(2)/2], 0);
            end
        end



              % Determine the outcome and update the outcome array
       if strcmp(selectedImageEXP, 'left')
           if position1EXP == 1 && leftProbabilityEXP > rightProbabilityEXP
                outcomeArrayEXP(trial) = 1;
                utility_ArrayEXP1(trialNumEXP) = 1;
                scoreEXP = scoreEXP + 1;
           elseif position1EXP == 2 && rightProbabilityEXP > leftProbabilityEXP
            outcomeArrayEXP(trial) = 1;
            utility_ArrayEXP1(trialNumEXP) = 0;
            scoreEXP = scoreEXP - 1;
           end
       elseif strcmp(selectedImageEXP, 'right')
           if position1EXP == 1 && rightProbabilityEXP > leftProbabilityEXP
            outcomeArrayEXP(trial) = 1;
            utility_ArrayEXP1(trialNumEXP) = 1;
            scoreEXP = scoreEXP + 1;
           elseif position1EXP == 2 && leftProbabilityEXP > rightProbabilityEXP
            outcomeArrayEXP(trial) = 1;
            utility_ArrayEXP1(trialNumEXP) = 0;
            scoreEXP = scoreEXP - 1;
           end
       end
       scoreArrayEXP(trialNumEXP) = scoreEXP;

      % Inside the loop for the first part of the experiment
      leftProbabilitiesFirstPartEXP(block) = leftProbabilityEXP;
      rightProbabilitiesFirstPartEXP(block) = rightProbabilityEXP;






        vbl = Screen('Flip', window);
        WaitSecs(blankDuration);

        % pos and neg images based on the chosen probability array
        posTextureEXP = Screen('MakeTexture', window, Pos);
        negTextureEXP = Screen('MakeTexture', window, Neg);

        vbl = Screen('Flip', window);


        if outcome1EXP == 1
            Screen('DrawTexture', window, posTextureEXP, [], [xCenter-separation/2-imageSize(1) yCenter-imageSize(2)/2 xCenter-separation/2 yCenter+imageSize(2)/2], 0);
        else
            Screen('DrawTexture', window, negTextureEXP, [], [xCenter-separation/2-imageSize(1) yCenter-imageSize(2)/2 xCenter-separation/2 yCenter+imageSize(2)/2], 0);
        end
        if outcome2EXP == 1
            Screen('DrawTexture', window, posTextureEXP, [], [xCenter+separation/2 yCenter-imageSize(2)/2 xCenter+separation/2+imageSize(1) yCenter+imageSize(2)/2], 0);
        else
            Screen('DrawTexture', window, negTextureEXP, [], [xCenter+separation/2 yCenter-imageSize(2)/2 xCenter+separation/2+imageSize(1) yCenter+imageSize(2)/2], 0);
        end
        vbl = Screen('Flip', window); 
        WaitSecs(blankDuration);
        Screen('FillRect', window, white);
        Screen('Flip', window);

    end

end


disp('HELLO');

save(filenameEXP, 'selectedImagesFromEXP', 'selectedProbabilitiesFromEXP', 'elapsedTimeEXP', 'leftimEXP','rightimEXP','leftOutcomesEXP', 'rightOutcomesEXP','numTrialsEXP','scoreArrayEXP', 'outcomeArrayEXP', 'leftProbabilitiesFirstPartEXP', 'rightProbabilitiesFirstPartEXP', 'utility_ArrayEXP1', 'scoreArrayEXP');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Second Part of Main Experiment
%
%the second task: I need to take every image that was presented in the first task(and its corresponding probability) and preseent it in a block of 30 trials.
% this means, there are 6 blocks of of 30 trials and in each block one of the images from the first part will be selected for the given block and presented 
% on screen together with a randomly chosen pie chart image (in total, there are 28 pie chart images (and their respective probabilities). The position of 
% the pie chart (whether its left or right) as well as the position of the image (left or right) are randomized for each trial. Just like in the
% second task, the participant clicks on the image he wishes to select and a green rectangle appears around it. Again, like in the second task,
% there will be specific propabilites associated with the images and pie charts. When the participant selects the image which is displayed
% on the left, and the probability of the left image is higher than the probability of the right image, then the participant gets a point added
% to the current score, if the probability of the right image is higher than the proabbility of the left image, then the participant gets a point subtracted
% from the current score. The same goes for the other scenario, if the participant selects the image displayed on the right and the proability of the the right image
% is higher than the probability of the left image, the participant gets a point added to the current score, if the probability of the left image is higher,
% the participant gets a point subtracted from the current score.
% num_trials_per_blockEXP = 28;


% Instructions for the second training test: ES-Phase
line69 = 'TRAINING: Instructions for the second test:';
line70 = '\n\n  In the second test there will be two kinds of options.';
line71 = '\n\n\n  The first kind of option is represented by the symbols you already encountered during the previous test.';
line72 = '\n\n\n  Note: The symbols maintain the same odds of winning/losing a point as in the first test.';
line73 = '\n\n\n  The second kind of options is represented by pie-charts that describe the odds of winning/losing points';
line74 = '\n\n\n  through interleaved segments of specific green/red ratios.';
line75 = '\n\n\n  Specifically, the amount of green area indicates the chance of winning a point;';
line76 = '\n\n\n  the amount of red area indicates the chance of losing a point.';
line77 = '\n\n\n  These pie-charts will be of various types (one example is shown in the testing phase)';
line78 = '\n\n\n  Just as for the logos, pie-charts range from 90% chance of winning a point to 90% chance of losing a point.';
line79 = '\n\n\n  You will always be asked to chose between a pie-chart and an icon.';
line80 = '\n\n\n Please press the space bar to continue.';
Screen('TextSize', window, 18);
DrawFormattedText(window, [line69 line70 line71 line72 line73 line74 line75 line76 line77 line78 line79 line80],...
    'center', screenYpixels * 0.25, black);
Screen('Flip', window);
KbStrokeWait;

line81 = 'TRAINING: Instructions for the second test:';
line82= '\n\n In each round, you have to choose between one of two symbols displayed on either side of the screen.';
line83 = '\n\n\n  You can select the left symbol by pressing the "a" key and the right symbol by pressing the "k" key.';
line84 = '\n\n\n  Please note that in this test, no outcome will be displayed,';
line85 = '\n\n\n  such that after a choice, the next pair of options will be shown without an intermediate step.'; 
line86 = '\n\n\n  At the end of the test, you will be shown the final payoff in terms of cumulative points and monetary bonus';
line87 = '\n\n\n Please press the space bar to continue.';
Screen('TextSize', window, 18);
DrawFormattedText(window, [line81 line82  line83 line84 line85 line86 line87],...
    'center', screenYpixels * 0.25, black);
Screen('Flip', window);
KbStrokeWait;

line88 = 'Note: This test is like the second test of the training!';
line89 = 'This is the actual game, every point will be included in the final payoff. Ready?';
line90 = '\n\n\n Please press the space bar to continue.';
Screen('TextSize', window, 18);
DrawFormattedText(window, [line88 line89 line90],...
    'center', screenYpixels * 0.25, black);
Screen('Flip', window);
KbStrokeWait;


runsEXP2 = {1 2 3 4 5};
iconsEXP2 = allImageNamesEXP; % {1 2 3 4 5 6};
piechartProbsEXP2 = {1/8, 2/8, 3/8, 4/8, 5/8, 6/8, 7/8};
piechartTypesEXP2 = {1 2 3 4};

totalTrialsEXP2 = length(runsEXP2) * length(iconsEXP2) * length(piechartProbsEXP2) * length(piechartTypesEXP2);

scoreEXP2 = 0;
% left_outcomesEXP = zeros(1, num_trials_per_blockEXP);
% right_outcomesEXP = zeros(1, num_trials_per_blockEXP);
% selected_imagesEXP = cell(1, num_trials_per_blockEXP);
% selected_probabilitiesEXP = zeros(1, num_trials_per_blockEXP);
% clicks_arrayEXP = zeros(1, num_trials_per_blockEXP);

elapsed_timeEXP2 = zeros(1, totalTrialsEXP2);
left_imagesEXP2 = cell(1, totalTrialsEXP2);
right_imagesEXP2 = cell(1, totalTrialsEXP2);
left_probabilityEXP2 = cell(1, totalTrialsEXP2);
right_probabilityEXP2 = cell(1, totalTrialsEXP2);
selected_probabilityEXP2 = cell(1, totalTrialsEXP2);
selected_imageEXP2 = cell(1, totalTrialsEXP2);
selected_sideEXP2 = cell(1, totalTrialsEXP2);

trialRunsEXP2 = cell(1, totalTrialsEXP2);
trialIconsEXP2 = cell(1, totalTrialsEXP2);
trialPiechartProbsEXP2 = cell(1, totalTrialsEXP2);
trialPiechartTypesEXP2 = cell(1, totalTrialsEXP2);
outcomeArrayEXP2 = zeros(totalTrialsEXP2, 1);
leftOutcomesEXP2 = zeros(1, totalTrialsEXP2);
rightOutcomesEXP2 = zeros(1, totalTrialsEXP2);
clicksArrayEXP2 = zeros(totalTrialsEXP2, 1);
utility_ArrayEXP2 = zeros(1, totalTrialsEXP2);
scoreArrayEXP2 = zeros(totalTrialsEXP2, 1);


dataCellEXP2 = {
    elapsed_timeEXP2,
    left_imagesEXP2,
    right_imagesEXP2,
    left_probabilityEXP2,
    right_probabilityEXP2,
    selected_probabilityEXP2,
    selected_imageEXP2,
    selected_sideEXP2,
    trialRunsEXP2, 
    trialIconsEXP2,
    trialPiechartProbsEXP2,
    trialPiechartTypesEXP2,
    scoreEXP2, 
    outcomeArrayEXP2,
    leftOutcomesEXP2;
    rightOutcomesEXP2,
    clicksArrayEXP2,
    utility_ArrayEXP2,
    scoreArrayEXP2
};

filenameEXP2 = 'participant_dataEXP2.mat';

trialNumEXP2 = 1;

for i = 1:length(runsEXP2)
    for j = 1:length(iconsEXP2)
        for k = 1:length(piechartProbsEXP2)
            for l = 1:length(piechartTypesEXP2)
                trialRunsEXP2{trialNumEXP2} = runsEXP2{i};
                trialIconsEXP2{trialNumEXP2} = iconsEXP2{j};
                trialPiechartProbsEXP2{trialNumEXP2} = piechartProbsEXP2{k};
                trialPiechartTypesEXP2{trialNumEXP2} = piechartTypesEXP2{l};
                trialNumEXP2 = trialNumEXP2 + 1;
            end
        end             
    end
end

shuffle_indexEXP2 = randperm(totalTrialsEXP2);

trialRunsEXP2 = trialRunsEXP2(shuffle_indexEXP2);
trialIconsEXP2 = trialIconsEXP2(shuffle_indexEXP2);
trialPiechartProbsEXP2 = trialPiechartProbsEXP2(shuffle_indexEXP2);
trialPiechartTypesEXP2 = trialPiechartTypesEXP2(shuffle_indexEXP2);

% main loop for the blocks
%for blockEXP = 1:6

%     shuffled_indicesEXP = randperm(length(allPieChartProbabilitiesEXP));
%     shuffled_imagesEXP = allPieChartsEXP(shuffled_indicesEXP);
%     shuffled_probabilitiesEXP = allPieChartProbabilitiesEXP(shuffled_indicesEXP);
% 
%     current_imageEXP = allImagesEXP{block};
%     current_image_nameEXP = allImageNamesEXP{blockEXP};
%     current_image_probabilityEXP = allProbabilityArraysEXP{block};

for trialEXP2 = 1:totalTrialsEXP2
       if trialEXP2 == 10                                                                                           % !!!!!!! Currently breaking here, if you want to play the whole thing delete the loop.
           break
       end     
    runEXP2 = trialRunsEXP2{trialEXP2};
    iconNameEXP2 = trialIconsEXP2{trialEXP2};
    iconImageEXP2 = allImagesEXP{strcmp(allImageNamesEXP, iconNameEXP2)};

    iconIndexInPreviousPartEXP2 = find(strcmp(selectedImagesFromEXP, iconNameEXP2));
    iconProbabilityEXP2 = selectedProbabilitiesFromEXP(iconIndexInPreviousPartEXP2);


    piechartProbEXP2 = trialPiechartProbsEXP2{trialEXP2};
    piechartTypeEXP2 = trialPiechartTypesEXP2{trialEXP2};

    piechartImageEXP2 = imresize(generate_piechart(piechartProbEXP2, piechartTypeEXP2), imageSize);


    if rand() < 0.5
        leftImageEXP2 = iconImageEXP2;
        leftProbabilityEXP2 = iconProbabilityEXP2;
        leftImageNameEXP2 = iconNameEXP2;
        rightImageEXP2 = piechartImageEXP2;
        rightProbabilityEXP2 = piechartProbEXP2;
        rightImageNameEXP2 = ['Pie' num2str(piechartTypeEXP2)];
        
    else
        rightImageEXP2 = iconImageEXP2;
        rightProbabilityEXP2 = iconProbabilityEXP2;
        rightImageNameEXP2 = iconNameEXP2;
        leftImageEXP2 = piechartImageEXP2;
        leftProbabilityEXP2 = piechartProbEXP2;
        leftImageNameEXP2 = ['Pie' num2str(piechartTypeEXP2)];
    end

    left_textureEXP2 = Screen('MakeTexture', window, leftImageEXP2);
    right_textureEXP2 = Screen('MakeTexture', window, rightImageEXP2);

    separationEXP2 = 300;
    image_sizeEXP2 = [268, 268];
    leftPositionEXP2 = [xCenter-separationEXP2/2-image_sizeEXP2(1), yCenter-image_sizeEXP2(2)/2, xCenter-separationEXP2/2, yCenter+image_sizeEXP2(2)/2];
    rightPositionEXP2 = [xCenter+separationEXP2/2, yCenter-image_sizeEXP2(2)/2, xCenter+separationEXP2/2+image_sizeEXP2(1), yCenter+image_sizeEXP2(2)/2];

    Screen('DrawTexture', window, left_textureEXP2, [], leftPositionEXP2, 0);
    Screen('DrawTexture', window, right_textureEXP2, [], rightPositionEXP2, 0);

    vbl = Screen('Flip', window);

    selectedImageEXP2 = '';
    tic();
    while isempty(selectedImageEXP2)
        [~, keyCode, ~] = KbWait;
        keyPressed = KbName(find(keyCode));

        if strcmp(keyPressed, 'a')
            selectedImageEXP2 = 'left';
        elseif strcmp(keyPressed, 'k')
            selectedImageEXP2 = 'right';
        end
    end

    elapsed_timeEXP2(trialEXP2) = toc();
    selected_sideEXP2{trialEXP2} = selectedImageEXP2;
    left_imagesEXP2{trialEXP2} = leftImageNameEXP2;
    right_imagesEXP2{trialEXP2} = rightImageNameEXP2;
    left_probabilityEXP2{trialEXP2} = leftProbabilityEXP2;
    right_probabilityEXP2{trialEXP2} = rightProbabilityEXP2;

    Screen('DrawTexture', window, left_textureEXP2, [], leftPositionEXP2, 0);
    Screen('DrawTexture', window, right_textureEXP2, [], rightPositionEXP2, 0);

    if strcmp(selectedImageEXP2, 'left')
        selected_probabilityEXP2{trialEXP2} = leftProbabilityEXP2;
        selected_imageEXP2{trialEXP2} = leftImageNameEXP2;
        clicksArrayEXP2(trialEXP2) = 1;                          % Store left click (1) in the array
        Screen('FrameRect', window, [0, 255, 0], [xCenter-separationEXP2/2-imageSize(1)-10 yCenter-imageSize(2)/2-10 xCenter-separationEXP2/2+10 yCenter+imageSize(2)/2+10], 3);
        if leftProbabilityEXP2 > rightProbabilityEXP2
            scoreEXP2 = scoreEXP2 + 1;
            outcomeArrayEXP2(trialEXP2)= 1;
            leftOutcomesEXP2(trialEXP2) = 1;
            utility_ArrayEXP2(trialEXP2) = 1;
        else
            scoreEXP2 = scoreEXP2 - 1;
            outcomeArrayEXP2(trialEXP2)= 0;
            leftOutcomesEXP2(trialEXP2) = 0;
            utility_ArrayEXP2(trialEXP2) = 0;
        end
    elseif strcmp(selectedImageEXP2, 'right')
        selected_probabilityEXP2{trialEXP2} = rightProbabilityEXP2;
        selected_imageEXP2{trialEXP2} = rightImageNameEXP2;
        clicksArrayEXP2(trialEXP2) = 0;                                          % Store right click (0) in the array
        Screen('FrameRect', window, [0, 255, 0], [xCenter+separationEXP2/2-10 yCenter-imageSize(2)/2-10 xCenter+separationEXP2/2+imageSize(1)+10 yCenter+imageSize(2)/2+10], 3);
        if leftProbabilityEXP2 < rightProbabilityEXP2
            scoreEXP2 = scoreEXP2 + 1;
            outcomeArrayEXP2(trialEXP2) = 1;
            rightOutcomesEXP2(trialEXP2) = 1;
            utility_ArrayEXP2(trialEXP2) = 1;
        else
            scoreEXP2 = scoreEXP2 - 1;
            outcomeArrayEXP2(trialEXP2) = 0;
            rightOutcomesEXP2(trialEXP2) = 0;
            utility_ArrayEXP2(trialEXP2) = 0;
        end
    end
    scoreArrayEXP2(trialEXP2) = scoreEXP2;

    vbl = Screen('Flip', window);
    WaitSecs(blankDuration);

    display(scoreEXP2);
       
end

% Screen('Close', window);
% 
% sca;


%   for trialEXP = 1:num_trials_per_blockEXP
% 
%       currentPieChartImageEXP = shuffled_imagesEXP{trialEXP};
%       currentPieChartProbabilityEXP = shuffled_probabilitiesEXP(trialEXP);
%     
%     if rand() < 0.5
%         leftImageEXP = current_imageEXP;
%         leftProbabilityEXP = current_image_probabilityEXP;
% 
%         rightImageEXP = currentPieChartImageEXP;
%         rightProbabilityEXP = currentPieChartProbabilityEXP;
% 
%     else
%         rightImageEXP = current_imageEXP;
%         rightProbabilityEXP = current_image_probabilityEXP;
% 
%         leftImageEXP = currentPieChartImageEXP;
%         leftProbabilityEXP = currentPieChartProbabilityEXP;
%     end
%     
%     left_textureEXP = Screen('MakeTexture', window, leftImageEXP);
%     right_textureEXP = Screen('MakeTexture', window, rightImageEXP);
% 
%     separationEXP = 300;
%     image_sizeEXP = [268, 268];
%     leftPositionEXP = [xCenter-separationEXP/2-image_sizeEXP(1), yCenter-image_sizeEXP(2)/2, xCenter-separationEXP/2, yCenter+image_sizeEXP(2)/2];
%     rightPositionEXP = [xCenter+separationEXP/2, yCenter-image_sizeEXP(2)/2, xCenter+separationEXP/2+image_sizeEXP(1), yCenter+image_sizeEXP(2)/2];
% 
%     Screen('DrawTexture', window, left_textureEXP, [], leftPositionEXP, 0);
%     Screen('DrawTexture', window, right_textureEXP, [], rightPositionEXP, 0);
% 
%     vbl = Screen('Flip', window);
% 
% 
%     selectedImageEXP = '';
%     tic();
%     while isempty(selectedImageEXP)
%         [~, keyCode, ~] = KbWait;
%         keyPressed = KbName(find(keyCode));
% 
%         if strcmp(keyPressed, 'a')
%             selectedImageEXP = 'left';
%         elseif strcmp(keyPressed, 'k')
%             selectedImageEXP = 'right';
%         end
%     end
% 
%     elapsed_timeEXP(trial) = toc();
% 
%     Screen('DrawTexture', window, left_textureEXP, [], leftPositionEXP, 0);
%     Screen('DrawTexture', window, right_textureEXP, [], rightPositionEXP, 0);
% 
%     if strcmp(selectedImageEXP, 'a')
%         Screen('FrameRect', window, [0, 255, 0], [xCenter-separation/2-imageSize(1)-10 yCenter-imageSize(2)/2-10 xCenter-separation/2+10 yCenter+imageSize(2)/2+10], 3);
%         if leftProbability > rightProbability
%             scoreEXP = scoreEXP + 1;
%         else
%             scoreEXP = scoreEXP - 1;
%         end
%     elseif strcmp(selectedImageEXP2, 'k')
%         Screen('FrameRect', window, [0, 255, 0], [xCenter-separation/2-imageSize(1)-10 yCenter-imageSize(2)/2-10 xCenter-separation/2+10 yCenter+imageSize(2)/2+10], 3);
%         if leftProbability < rightProbability
%             scoreEXP = scoreEXP + 1;
%         else
%             scoreEXP = scoreEXP - 1;
%         end
%     end
% 
% %green rectangle implementation
% % Draw green rectangle around the selected image
% if strcmp(selectedImageEXP, 'left')
%     Screen('FrameRect', window, [0, 255, 0], [xCenter-separationEXP/2-image_sizeEXP(1)-10 yCenter-image_sizeEXP(2)/2-10 xCenter-separationEXP/2+10 yCenter+image_sizeEXP(2)/2+10], 3);
% elseif strcmp(selectedImageEXP, 'right')
%     Screen('FrameRect', window, [0, 255, 0], [xCenter+separationEXP/2-10 yCenter-image_sizeEXP(2)/2-10 xCenter+separationEXP/2+image_sizeEXP(1)+10 yCenter+image_sizeEXP(2)/2+10], 3);
% end
% 
% vbl = Screen('Flip', window);
% WaitSecs(blankDuration);
% 
% display(scoreEXP);
%        
%   end
% %end
% Screen('Close', window);
% 
% sca;

    
save(filenameEXP2, 'scoreEXP2', 'elapsed_timeEXP2', 'left_imagesEXP2', 'right_imagesEXP2', 'left_probabilityEXP2', 'right_probabilityEXP2', 'selected_probabilityEXP2', 'selected_imageEXP2', 'selected_sideEXP2', 'trialRunsEXP2', 'trialIconsEXP2', 'trialPiechartProbsEXP2', 'trialPiechartTypesEXP2', 'outcomeArrayEXP2', 'leftOutcomesEXP2', 'rightOutcomesEXP2', 'clicksArrayEXP2', 'utility_ArrayEXP2', 'scoreArrayEXP2')
selectedImagesFromPartsEXP2 = iconsEXP2;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%  Testing Phase: Slider - Task  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Slider task 
% Instructions

black = BlackIndex(screenNumber);
white = WhiteIndex(screenNumber);
grey = white / 2;    
line91 = 'EXPERIMENT: Instructions for the third test:';
line92= '\n\n  In each round of the third test you will be presented with the symbols and pie-charts you met in the first and second test.';
line93 = '\n\n\n  This is now the occasion where we test your knowledge of each symbol average outcome.';
line94 = '\n\n\n   1.You will be asked to indicate (in percentage), what are the odds that a given symbol or pie-chart makes you win a point (+1 = + 0.002p).';
line95 = '\n\n\n   2.There will be a scale below the slider through which you can indicate the confidence you have in your estimation of the above probability:'; 
line96 = '\n\n\n   1 means you are not at all sure what the probability is and 5 means you are absolutely sure,';
line97 = '\n\n\n   You can move the sliders on screen with the mouse cursor';
line98 = '\n\n\n Please press the space bar to continue.';
Screen('TextSize', window, 18);
DrawFormattedText(window, [line91 line92 line93 line94 line94 line95 line96 line97 line98],...
    'center', screenYpixels * 0.25, black);
Screen('Flip', window);
KbStrokeWait;

%%%%%%%%% General Parameters %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
textSize = 18; 
sliderLineWidth = 10;
dim = screenYpixels / 50;
hDim = dim / 2;
smallTextSize = 15;
scaleLineWidth = 6;
% Define colors
red = [black 0 0];
green = [0 black 0];
blue = [0 0 black];
yellowTrans = [black black black 0.5]; 

%%%%%%%% Slider 1 Parameters %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

sliderLengthPix = screenYpixels / 1.5;
sliderHLengthPix = sliderLengthPix / 2;
leftEnd = [xCenter - sliderHLengthPix yCenter + sliderHLengthPix * 0.6];
rightEnd = [xCenter + sliderHLengthPix yCenter + sliderHLengthPix * 0.6];
sliderLineCoords = [leftEnd' rightEnd'];
sliderLabels = {'0%', '100%'};
SetMouse(xCenter, yCenter, window);
offsetSet = 0;
% Initialize centeredRect for Slider 1 to a random position
baseRect = [0 0 dim dim]; 
sx = xCenter + (rand * 2 - 1) * sliderHLengthPix;
centeredRect = CenterRectOnPointd(baseRect, sx, yCenter + sliderHLengthPix * 0.6);
aboveSliderPosY2 = yCenter + sliderHLengthPix * 0.4; %  value for aboveSliderPosY + textPixGap????
textPixGap = 70;
textPixGap2 = 60;
slider1LeftBound = xCenter - sliderHLengthPix;
slider1RightBound = xCenter + sliderHLengthPix;
slider1TopBound = yCenter + sliderHLengthPix * 0.6 - dim / 2;
slider1BottomBound = yCenter + sliderHLengthPix * 0.6 + dim / 2;

%%%%%%%% Slider 2 Parameters %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 

leftLabel = 'very uncertain';
rightLabel = 'very confident';
bottomY = screenYpixels * 0.8; % position of Slider 2 (lower 20 percent of the screen)
textPosY = bottomY - hDim - textPixGap;
scaleLengthPix = screenYpixels / 1.5;
scaleHLengthPix = scaleLengthPix / 2;
leftEnd2 = [xCenter - scaleHLengthPix, bottomY]; 
rightEnd2 = [xCenter + scaleHLengthPix, bottomY]; 
scaleLineCoords2 = [leftEnd2', rightEnd2'];
numScalePoints2 = 5;
xPosScalePoints2 = linspace(xCenter - scaleHLengthPix, xCenter + scaleHLengthPix, numScalePoints2);
numScalePoints2Offset = 0; 
yPosScalePoints2 = repmat(bottomY + numScalePoints2Offset, 1, numScalePoints2); 
xyScalePoints2 = [xPosScalePoints2; yPosScalePoints2];
leftTextPosX2 = xCenter - scaleHLengthPix - hDim - textPixGap2 - textSize * 30;
rightTextPosX2 = xCenter + scaleHLengthPix + hDim + textPixGap2 + textSize * 20;
textPosY2 = bottomY + hDim + textPixGap; 
numShiftUpPix = 30; 
xNumText2 = xPosScalePoints2 - hDim;
yNumText2 = repmat(bottomY - numShiftUpPix, 1, numScalePoints2); 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

numTrialsSliderEXP = 6;
SliderResponsesEXP = cell(numTrialsSliderEXP, 1);
selectedImageNameSliderEXP = cell(numTrialsSliderEXP, 1);
confidenceLevelsEXP = zeros(numTrialsSliderEXP, 1); 
thisNumSliderEXP = 1; % Initialize thisNum to a default value


for trial = 1:numTrialsSliderEXP
    selectedImageIdxSliderEXP = randi(numel(selectedImagesFromPartsEXP2));                                               %  random index between 1 and the number of elements in the selectedImagesFromPartsTEST cell array, index is used to randomly select an image name.
    selectedImageNameSliderEXP{trial} = selectedImagesFromPartsEXP2{selectedImageIdxSliderEXP};                         % Assigns the selected image name to the selectedImageNameSliderTEST array at the current trial index.
    imageIndexSliderEXP = find(strcmp(allImageNamesEXP, selectedImageNameSliderEXP{trial}));                           % Searches for the index of the selected image name within the allImageNamesTEST cell array.
    selectedImageSliderEXP = allImagesEXP{imageIndexSliderEXP};                                                        % Retrieves the selected image data from the allImagesTEST cell array based on the found index.
    selectedImagesFromPartsEXP2(selectedImageIdxSliderEXP) = [];                                                         % reomves it from the array to avoid repetition of samw image

    [imageHeight, imageWidth, ~] = size(selectedImageSliderEXP);
    imageRect = [0, 0, imageWidth, imageHeight];
    imageDestinationRect = CenterRectOnPointd(imageRect, xCenter, yCenter - imageHeight/8);                               % imageHeight/8 will move the image slightly up to fit the slider task outline

    currentPercentageEXP = -1;
    selectedConfidenceEXP = 0;

    while true
        Screen('DrawTexture', window, Screen('MakeTexture', window, selectedImageSliderEXP), [], imageDestinationRect);
        Screen('DrawTexture', window, Screen('MakeTexture', window, selectedImageSliderEXP), [], imageDestinationRect);
        [mx, my, buttons] = GetMouse(window);

        if mx >= slider1LeftBound && mx <= slider1RightBound && my >= slider1TopBound && my <= slider1BottomBound         % condition checks if the mouse cursor is within the bounds, the region where the slider can be interacted with.
             % Draw Slider 1
           sx = mx;
           if sx > xCenter + sliderHLengthPix
              sx = xCenter + sliderHLengthPix;
           elseif sx < xCenter - sliderHLengthPix
              sx = xCenter - sliderHLengthPix;
           end
           centeredRect = CenterRectOnPointd(baseRect, sx, yCenter + sliderHLengthPix * 0.6);
        end
        Screen('DrawLines', window, sliderLineCoords, sliderLineWidth, black);
        Screen('FillRect', window, yellowTrans, centeredRect);
        Screen('FrameRect', window, green, centeredRect);

       % labels for '0%' and '100%'
       leftTextPosX2 = xCenter - scaleHLengthPix - hDim - textPixGap2 - textSize * 2;
       rightTextPosX2 = xCenter + scaleHLengthPix + hDim + textPixGap2 - textSize * 3;

       DrawFormattedText(window, sliderLabels{1}, leftTextPosX2, aboveSliderPosY2, blue);
       DrawFormattedText(window, sliderLabels{2}, rightTextPosX2, aboveSliderPosY2, red);
       DrawFormattedText(window, 'What are the odds that this symbol yields a +1?', 'center', screenYpixels * 0.25, black);
       currentPercentageEXP = round((sx - (xCenter - sliderHLengthPix)) / sliderLengthPix * 100);
       DrawFormattedText(window, [num2str(currentPercentageEXP) '%'], 'center', aboveSliderPosY2, black);
       
       % Draw Slider 2                                                                                                     % Get mouse position relative to the window
       inCircles = sqrt((xPosScalePoints2 - mx).^2 + (yPosScalePoints2 - my).^2) < hDim;
       weInCircle = sum(inCircles) > 0;
       if weInCircle == 1
           [~, posCircle] = max(inCircles);
           coordsCircle = xyScalePoints2(:, posCircle);
           selectedConfidenceEXP = posCircle;                                                                               % Store the selected confidence level
       end
       Screen('DrawLines', window, scaleLineCoords2, scaleLineWidth, grey);

    % labels for 'very certain' and 'very uncertain'
       DrawFormattedText(window, leftLabel, xCenter - scaleHLengthPix, textPosY2, black);
       DrawFormattedText(window, rightLabel, xCenter + scaleHLengthPix - textSize * 10, textPosY2, black);

       if selectedConfidenceEXP ~= 0
          Screen('FrameOval', window, grey, [coordsCircle - dim * 0.8; coordsCircle + dim * 0.8], 2);
       end
       for i = 1:numScalePoints2
           Screen('FillOval', window, black, [xPosScalePoints2(i) - hDim, yPosScalePoints2(i) - hDim, xPosScalePoints2(i) + hDim, yPosScalePoints2(i) + hDim]);
       end
       Screen('TextSize', window, smallTextSize);
       for thisNumSliderEXP = 1:numScalePoints2
           DrawFormattedText(window, num2str(thisNumSliderEXP), xNumText2(thisNumSliderEXP), yNumText2(thisNumSliderEXP), black);
       end
       Screen('TextSize', window, textSize);
       Screen('Flip', window);

         % is space bar pressed
        [keyIsDown, ~, keyCode] = KbCheck(-1);
        if keyIsDown && keyCode(KbName('space')) & currentPercentageEXP ~= -1 & selectedConfidenceEXP ~= 0
            break
        end
    end
    % Update confidence level for the current trial
    confidenceLevelsEXP(trial) = selectedConfidenceEXP;

    % record the response
    SliderResponsesEXP{trial}.imageName = selectedImageNameSliderEXP{trial};
    SliderResponsesEXP{trial}.sliderValue = currentPercentageEXP;
    SliderResponsesEXP{trial}.confidenceLevel = confidenceLevelsEXP(trial);

    WaitSecs(blankDuration); 
end

% Save the slider task responses to a MAT file
filenameSliderEXP = 'SliderResponsesEXP.mat';
save(filenameSliderEXP, 'SliderResponsesEXP');


%Let's say goodbye :)
endMessage = 'Yeah, you survived! Thanks for participating. Please contact the experimenter.';
Screen('TextSize', window, 22);
DrawFormattedText(window, endMessage, 'center', 'center', black);
Screen('Flip', window);
KbStrokeWait;

sca;