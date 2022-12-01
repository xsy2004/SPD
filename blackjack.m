% BlackJack

clc
clear



init = simpleGameEngine('retro_cards.png',16,16,10,[0,100,0]);
gameLogic(init)
function gameLogic(init)
    
    % gamerStatus = 0;
    % defint variable
    gameStatus = 0;
    count = 0;
    card_sprites = 21:72;
    

    board_display(:,:) = 1 * ones(5,5);

    drawScene(init, board_display)
    text(60, 300, "Welcome Play Blackjack Game", 'FontSize', 25,'Color','white')
    % Start button
    annotation('textbox', [0.3 0.2 0.1 0.1], 'String', 'Start','FontSize', 28, 'FontWeight','bold', 'Color', [0.3010 0.7450 0.9330],'LineWidth',2, Margin=1, HorizontalAlignment='center')
    % Exit Button
    annotation('textbox', [0.6 0.2 0.1 0.1], 'String', 'Exit','FontSize', 28, 'FontWeight','bold', 'Color', [0.3010 0.7450 0.9330],'LineWidth',2, Margin=1, HorizontalAlignment='center')

    [x,y] = getMouseInput(init);
    if isequal([x y],[5 2]) == 1 || isequal([x y],[4 2]) == 1 || isequal([x y],[5 3]) == 1
        gameStatus = 1;
        clf
    else
        close all
    end

    if gameStatus == 1
        [sum_ai, sum_user, board_display] = reDeal(init, card_sprites);
        string_user = sprintf("Your score %.f", sum_user);
        text_user = text(80, 400, string_user, 'FontSize', 20);
        
    
        string_ai = sprintf("AI score %.f", sum_ai(1));
        text_ai = text(480, 400, string_ai, 'FontSize', 20);
    
        % make some text button
        %text(200, 530, "Hit", 'FontSize', 25, 'FontWeight','bold', 'Color', [0.3010 0.7450 0.9330])
        %text(500, 530, "Stand", 'FontSize', 25, 'FontWeight','bold', 'Color', [0.3010 0.7450 0.9330])
        credit = 1000;
        string_credit = sprintf("Availiable Credit %.f", credit);
        text_credit = text(200, 300, string_credit, 'FontSize', 20);
        % Hit button
        annotation('textbox', [0.3 0.3 0.1 0.1], 'String', 'Hit','FontSize', 23, 'FontWeight','bold', 'Color', [0.3010 0.7450 0.9330],'LineWidth',2, Margin=1, HorizontalAlignment='center')
    
        % Stand Button
        annotation('textbox', [0.6 0.3 0.1 0.1], 'String', 'Stand','FontSize', 23, 'FontWeight','bold', 'Color', [0.3010 0.7450 0.9330],'LineWidth',2, Margin=1, HorizontalAlignment='center')
    
        % Split Button
        visible = 'off';
        annotation('textbox', [0.5 0.3 0.1 0.1], 'String', 'Split','FontSize', 23, 'FontWeight','bold', 'Color', [0.3010 0.7450 0.9330],'LineWidth',2, Margin=1, HorizontalAlignment='center', Visible=visible)
        
        
        
        while credit >= 0
            deal = board_display(5,:)
            drawScene(init, board_display)
            if true
                nullPosition = find(deal == 2);
                count = count + 1;
                [x,y] = getMouseInput(init);
                % board_display(x,y) = 11;
    
                % Hit action
                if isequal([x y],[4 2]) == 1 && count < 3
                    lose_notice.String = '';
                    win_notice.String = '';
                    push_notice.String = '';
                    % user
                    card = getRandomCard(1);
                    board_display(5,nullPosition(count)) = card_sprites(card);
                    sum_user = sum_user + calculateSum(card);
                    text_user.String = sprintf("Your score %.f", sum_user);
                    % ai
                    ai_card = getRandomCard(1);
                    board_display(1,nullPosition(count)) = card_sprites(ai_card);
                    sum_ai = sum_ai  + calculateSum(ai_card);
                    text_ai.String = sprintf("AI score %.f", sum_ai(1));
    
                    if sum_user == sum(sum_ai) || sum_user > 21 && sum(sum_ai) > 21
                        [push_notice, lose_notice, win_notice] =  pushStyle(init, board_display);
                        [sum_ai, sum_user, board_display] = reDeal(init, card_sprites);
                        text_user.String = sprintf("Your score %.f", sum_user);
                    elseif sum_user > 21 && ~sum(sum_ai) > 21 || sum(sum_ai) > sum_user
                        credit = credit - 100;
                        string_credit = sprintf("Availiable Credit %.f ", credit);
                        text_credit.String = string_credit;
                        lose_notice = LoseStyle(init,board_display);
                        
                        sum_user = 0;
                        text_user.String = sprintf("Your score %.f", sum_user);
                        [sum_ai, sum_user, board_display] = reDeal(init, card_sprites);
                        text_user.String = sprintf("Your score %.f", sum_user);
                    elseif sum(sum_ai) > 21 && ~sum_user > 21 || sum(sum_ai) < sum_user
                        credit = credit + 100;
                        string_credit = sprintf("Availiable Credit %.f ", credit);
                        text_credit.String = string_credit;
                        win_notice = winStyle(init, board_display)
                        
                        sum_user = 0;
                        text_user.String = sprintf("Your score %.f", sum_user);
                        [sum_ai, sum_user, board_display] = reDeal(init, card_sprites);
                        text_user.String = sprintf("Your score %.f", sum_user);
                    end
            end
            count = 0;

            % Stand action
            if isequal([x y],[4 4]) == 1
                lose_notice.String = '';
                win_notice.String = '';
                push_notice.String = '';
                % find who win
                if sum_user == sum(sum_ai) || sum_user > 21 && sum(sum_ai) > 21
                    [push_notice, lose_notice, win_notice] =  pushStyle(init, board_display);
                    [sum_ai, sum_user, board_display] = reDeal(init, card_sprites);
                    text_user.String = sprintf("Your score %.f", sum_user);
                elseif sum_user < sum(sum_ai) && sum_user < 21 && sum(sum_ai) < 21
                        credit = credit - 100;
                        string_credit = sprintf("Availiable Credit %.f ", credit);
                        text_credit.String = string_credit;
                        lose_notice = LoseStyle(init,board_display);
                        
                        sum_user = 0;
                        text_user.String = sprintf("Your score %.f", sum_user);
                        [sum_ai, sum_user, board_display] = reDeal(init, card_sprites);
                        text_user.String = sprintf("Your score %.f", sum_user);
                elseif sum_user > sum(sum_ai) && sum_user < 21 && sum(sum_ai) < 21
                        credit = credit + 100;
                        string_credit = sprintf("Availiable Credit %.f ", credit);
                        text_credit.String = string_credit;
                        win_notice = winStyle(init, board_display)
                        
                        sum_user = 0;
                        text_user.String = sprintf("Your score %.f", sum_user);
                        [sum_ai, sum_user, board_display] = reDeal(init, card_sprites);
                        text_user.String = sprintf("Your score %.f", sum_user);
                end
            end

         end
            drawScene(init, board_display)
            
        end
        clf
        board_display(:,:) = 1 * ones(5,5);
        drawScene(init, board_display)
        text(180, 300, "Game Stop", 'FontSize', 30,'Color','white')
        % try again button
        annotation('textbox', [0.4 0.3 0.1 0.1], 'String', 'Try again','FontSize', 23, 'FontWeight','bold', 'Color', [0.3010 0.7450 0.9330],'LineWidth',2, Margin=1, HorizontalAlignment='center')
        [x,y] = getMouseInput(init);
        drawScene(init, board_display)
        if isequal([x y],[4 3]) == 1 || isequal([x y],[4 2]) == 1 || isequal([x y],[4 4]) == 1
            clf
            clc
            gameLogic(init)


        end
    end
    
    

    
end

function result = calculateSum(x)
    for index = 1:length(x)
        if x(index) > 13 && x(index) <= 13 * 2
            x(index) = x(index) - 13;
        end
        if x(index) > 13 * 2 && x(index) <= 13 * 3
            x(index) = x(index) - 13 * 2;
        end
        if x(index) > 13 * 3 && x(index) <= 13 * 4
            x(index) = x(index) - 13 * 3;
        end
        if ismember(x(index),[11 12 13]) == 1
            x(index) = 10;
        end
    end
    result = x;
end

function result =  getRandomCard(x)
    random_choose = randperm(52);
    % initial ai deal
    result = random_choose(1:x);
end

function [sum_ai, sum_user, result] = reDeal(init, card_sprites)
        % make a empty board
        board_display(:,:) = 2 * ones(5,5);
        board_display(2:4,:) = 1;
    
    
        % initial ai deal
        pickup_ai = getRandomCard(2);
        board_display(1,2:3) = [card_sprites(pickup_ai(1)) 11];
        sum_ai = calculateSum(pickup_ai());

        % initial user deal
        pickup_user = getRandomCard(2);
        board_display(5,2:3) = card_sprites(pickup_user());
        sum_user = sum(calculateSum(pickup_user()));

        result = board_display;
        drawScene(init, board_display)
        
end

function win_notice = winStyle(init, board_display)
    drawScene(init, board_display)
    win_notice = text(300, 300, "Your win", 'FontSize', 25,'Color','white');
end

function lose_notice =  LoseStyle(init, board_display)
    drawScene(init, board_display)
    lose_notice = text(300, 300, "AI Win", 'FontSize', 35,'Color','white');
end

function [push_notice, lose_notice, win_notice] =  pushStyle(init, board_display)
    drawScene(init, board_display)
    push_notice = text(300, 300, "Push", 'FontSize', 35,'Color','white');
    lose_notice.String = '';
    win_notice.String = '';
    
end



