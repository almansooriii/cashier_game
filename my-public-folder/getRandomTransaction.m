function [priceCents, payCents, changeCents] = getRandomTransaction()
    possiblePrices = 50:5:1995;
    priceCents = possiblePrices(randi(numel(possiblePrices)));

    possibleBills = [100, 500, 1000, 2000];
    validBills = possibleBills(possibleBills >= priceCents);
    payCents = validBills(randi(numel(validBills)));

    changeCents = payCents - priceCents;
end