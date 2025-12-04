clear;
clc;

TILE_SIZE = 80;

scene = simpleGameEngine('cashier_pack3.png',  TILE_SIZE, TILE_SIZE, 4, [0 0 0]);

numRows = 10;
numCols = 20;

FLOOR_TILE    = 2;
COUNTER_TILE  = 3;
WALL_TILE     = 4;
REGISTER_TILE = 5;
CUSTOMER_TILE = 6;
CHECK_TILE    = 7;
X_TILE        = 8;
MONEY_TILE    = 9;
COIN_TILE     = 10;

background = ones(numRows, numCols);

floorRows = 8:10;
background(floorRows, :) = FLOOR_TILE;

wallRow = 3;
background(wallRow, :) = WALL_TILE;

counterRow = 6;
counterTopRow = 5;
background(counterRow, :) = COUNTER_TILE;
registerCol = round(numCols / 2);
background(counterTopRow, registerCol) = REGISTER_TILE;


MAX_CUSTOMERS = 10;
lives        = 3;
score        = 0;

gameOver = false;

for customer = 1:MAX_CUSTOMERS
    if lives <= 0 || gameOver
        break;
    end

    [priceCents, payCents, changeCents] = getRandomTransaction();

    [userCents, quitFlag] = getChangeFromUser(scene, background, ...
        priceCents, payCents, lives, score, customer);

    if quitFlag
        gameOver = true;
        break;
    end

    if userCents == changeCents
        score = score + 1;

        scene.drawScene(background);
        figure(scene.my_figure);
        title(sprintf(['Customer %d   Total: $%.2f   Paid: $%.2f\n' ...
                       'Correct! Change is $%.2f   Score: %d   Lives: %d'], ...
            customer, priceCents/100, payCents/100, changeCents/100, score, lives));
        pause(1.0);
    else
        lives = lives - 1;

        scene.drawScene(background);
        figure(scene.my_figure);
        title(sprintf(['Customer %d   Total: $%.2f   Paid: $%.2f\n' ...
                       'Wrong. Correct change is $%.2f   Score: %d   Lives: %d'], ...
            customer, priceCents/100, payCents/100, changeCents/100, score, lives));
        pause(1.5);

        if lives <= 0
            gameOver = true;
        end
    end
end

scene.drawScene(background);
figure(scene.my_figure);

if lives <= 0
    finalMsg = 'You ran out of lives.';
elseif gameOver
    finalMsg = 'You ended your shift early.';
else
    finalMsg = 'Shift complete!';
end

title(sprintf(['CASHIER CHANGE GAME\n' ...
               '%s\n' ...
               'Final score: %d correct out of %d customers'], ...
               finalMsg, score, MAX_CUSTOMERS));
