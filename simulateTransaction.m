function listings = simulateTransaction(listings, itemName, buyerEmail, users)
   itemFound = false;
   buyerFound = false;
   % Find the item and ensure it's available
   for i = 1:size(listings, 1)
       if strcmpi(listings{i, 2}, itemName) && strcmp(listings{i, 6}, 'Available')
           % Check if the buyer is registered
           for j = 1:size(users, 1)
               if strcmp(users{j, 2}, buyerEmail)
                   buyerFound = true;
                   break;
               end
           end
           if ~buyerFound
               fprintf('Error: Buyer "%s" is not registered.\n', buyerEmail);
               return;
           end
           % Mark item as 'Sold'
           listings{i, 6} = 'Sold';
           % Ensure the data directory exists
           if ~exist('../data', 'dir')
               mkdir('../data');
           end
           save('../data/listings.mat', 'listings');
           fprintf('Success! "%s" has been purchased by %s.\n', itemName, buyerEmail);
           itemFound = true;
           break;
       end
   end
   if ~itemFound
       fprintf('Error: "%s" is not available for purchase.\n', itemName);
   end
end
