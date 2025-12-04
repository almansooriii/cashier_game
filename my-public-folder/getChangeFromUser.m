function [userCents, quitFlag] = getChangeFromUser(scene, background, ...
    priceCents, payCents, lives, score, customer)

    inputStr = '';
    quitFlag = false;

    while true
        scene.drawScene(background);

        figure(scene.my_figure);
        title(sprintf(['Customer %d   Total: $%.2f   Paid: $%.2f\n' ...
                       'Lives: %d   Score: %d\n' ...
                       'Type the change (e.g., 2.35) and press Enter.\n' ...
                       'Press Backspace to erase, Esc to quit.\n' ...
                       'Your input: %s'], ...
            customer, priceCents/100, payCents/100, lives, score, inputStr));

        key = scene.getKeyboardInput();

        switch key
            case {'return', 'enter'}
                if ~isempty(inputStr)
                    val = str2double(inputStr);
                    if ~isnan(val)
                        userCents = round(val * 100);
                        return;
                    end
                end

            case 'escape'
                userCents = [];
                quitFlag = true;
                return;

            case 'backspace'
                if ~isempty(inputStr)
                    inputStr(end) = [];
                end

            otherwise
                ch = key;

                if startsWith(key, 'numpad')
                    ch = key(end);
                elseif strcmp(key, 'period')
                    ch = '.';
                end

                if ismember(ch, ['0':'9', '.'])
                    if ~(ch == '.' && contains(inputStr, '.'))
                        inputStr(end+1) = ch;
                    end
                end
        end
    end
end