% BlackJack

clc
clear


gameLogic("test")


function result = gameLogic(x)
    init = simpleGameEngine('retro_cards.png',16,16,8,[0,100,0]);
    % gamerStatus = 0;
    % defint variable
    empty = 1;
    cards = 0;
    card_sprites = 21:72;
    % make a empty board
    board_display(:,:) = empty * ones(10,10);

    % random choose card
    random_choose = randperm(52);
    % just get number what you need
    pickup = random_choose(1:10);
    board_display(1,1:10) = card_sprites(pickup);


    drawScene(init, board_display)
end

