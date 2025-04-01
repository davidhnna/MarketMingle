Main 
clc;
clear;
close all;
clc;
clearvars;
close all;
% Define save directory and file
saveDir = '../data';
saveFile = fullfile(saveDir, 'users.mat');
% Ask user whether to use old save data or create a new one
choice = input("Use existing user data? (y/n): ", 's');
if strcmpi(choice, 'y') && exist(saveFile, 'file')
 % Load existing user data
 load(saveFile, 'users');
 disp("Loaded existing user data.");
else
 % Create a new save file
 users = {}; % Initialize an empty cell array
 save(saveFile, 'users'); % Save the empty file
 disp("Created a new user data file.");
end
while true
% Display menu
fprintf("\n=== Second-Hand Marketplace ===\n");
fprintf("1. Register User\n");
fprintf("2. Display Users\n");
fprintf("3. Create Listing\n");
fprintf("4. Search Items\n");
fprintf("5. Edit Listing\n");
fprintf("6. Find Best Matches\n");
fprintf("7. Simulate Transaction\n");
fprintf("8. Set Preferences\n");
fprintf("9. Exit\n");
choice = input("Enter your choice: ", 's'); % Read as string to prevent errors
% Convert choice to numeric if possible
if isempty(choice) || isnan(str2double(choice))
    fprintf("Invalid choice. Please enter a number between 1 and 9.\n");
    continue;  % Skip this loop iteration
end
choice = str2double(choice);
if choice < 1 || choice > 9
    fprintf("Invalid choice. Please enter a number between 1 and 9.\n");
    continue;  % Skip this loop iteration
end
switch choice
    case 1  % Register User
        name = input("Enter your name: ", 's');
        email = input("Enter your email: ", 's');
        location = input("Enter your location: ", 's');
        minPrice = input("Enter min price: ");
        maxPrice = input("Enter max price: ");
        category = input("Enter preferred category: ", 's');
        condition = input("Enter preferred condition: ", 's');
        % Store price range as a 2-element vector
        priceRange = [minPrice, maxPrice];
        % Register user
        users = registerUser(users, name, email, location, priceRange, category, condition);
    case 2  % Display Users
        if isempty(users)
            fprintf("No users registered yet.\n");
        else
            fprintf("\n=== Registered Users ===\n");
            for i = 1:size(users, 1)
                fprintf("Name: %s, Email: %s, Location: %s\n", ...
                        users{i, 1}, users{i, 2}, users{i, 3});
            end
        end
    case 3
        % Create Listing
        username = input('Enter your username: ', 's');
        item = input('Enter item name: ', 's');
        price = input('Enter price: ');
        condition = input('Enter condition ("New", "Good", "Fair", "Like New", "Any"): ', 's');
        location = input('Enter location: ', 's');
        if isnan(price) || price <= 0
            disp('Error: Price must be a positive number.');
            continue;
        end
        % Ensure listings exist before adding a new one
        if ~exist('listings', 'var')
            listings = {};
        end
    
        listings = createListing(listings, username, item, price, condition, location);
    case 4 % Search Items
        if ~exist('listings', 'var') || isempty(listings)
            fprintf("No listings available.\n");
            continue;
        end
        searchItem = input("Enter item name (or press Enter to skip): ", 's');
        minSearchPrice = input("Enter minimum price (or press Enter to skip): ", 's');
        maxSearchPrice = input("Enter maximum price (or press Enter to skip): ", 's');
        searchCondition = input("Enter condition ('New', 'Good', 'Fair', 'Like New', 'Any' or press Enter to skip): ", 's');
        % Convert price inputs to numbers
        if isempty(minSearchPrice)
            minSearchPrice = -inf; % No lower limit
        else
            minSearchPrice = str2double(minSearchPrice);
        end
        if isempty(maxSearchPrice)
            maxSearchPrice = inf; % No upper limit
        else
            maxSearchPrice = str2double(maxSearchPrice);
        end
        % Filter listings based on search criteria
        fprintf("\n=== Search Results ===\n");
        found = false;
        for i = 1:size(listings, 1)
            listing = listings(i, :);
            itemName = listing{2};
            itemPrice = listing{3};
            itemCondition = listing{4};
            if (~isempty(searchItem) && ~contains(lower(itemName), lower(searchItem))) || ...
               (itemPrice < minSearchPrice || itemPrice > maxSearchPrice) || ...
               (~isempty(searchCondition) && ~strcmpi(searchCondition, 'Any') && ~strcmpi(itemCondition, searchCondition))
                continue;
            end
            fprintf("Seller: %s | Item: %s | Price: %.2f | Condition: %s | Location: %s\n", ...
                    listing{1}, itemName, itemPrice, itemCondition, listing{5});
            found = true;
        end
        if ~found
            fprintf("No matching items found.\n");
        end
    case 5  % Edit Listing
        if ~exist('listings', 'var') || isempty(listings)
            fprintf("No listings available to edit.\n");
            continue;
        end
        username = input("Enter your username: ", 's');
        itemToEdit = input("Enter the item name you want to edit: ", 's');
        % Find the listing index
        listingIndex = -1;
        for i = 1:size(listings, 1)
            if strcmp(listings{i, 1}, username) && strcmpi(listings{i, 2}, itemToEdit)
                listingIndex = i;
                break;
            end
        end
        if listingIndex == -1
            fprintf("No matching listing found for the given username and item.\n");
            continue;
        end
        % Display current details
        fprintf("\nCurrent Listing Details:\n");
        fprintf("Seller: %s | Item: %s | Price: %.2f | Condition: %s | Location: %s\n", ...
                listings{listingIndex, 1}, listings{listingIndex, 2}, ...
                listings{listingIndex, 3}, listings{listingIndex, 4}, listings{listingIndex, 5});
        % Ask for new values (or keep existing ones)
        newItem = input("Enter new item name (or press Enter to keep the same): ", 's');
        if isempty(newItem)
            newItem = listings{listingIndex, 2};
        end
        newPrice = input("Enter new price (or press Enter to keep the same): ", 's');
        if isempty(newPrice)
            newPrice = listings{listingIndex, 3};
        else
            newPrice = str2double(newPrice);
            if isnan(newPrice) || newPrice <= 0
                fprintf("Invalid price. Keeping previous value.\n");
                newPrice = listings{listingIndex, 3};
            end
        end
        newCondition = input("Enter new condition ('New', 'Good', 'Fair', 'Like New', 'Any') (or press Enter to keep the same): ", 's');
        if isempty(newCondition)
            newCondition = listings{listingIndex, 4};
        end
        newLocation = input("Enter new location (or press Enter to keep the same): ", 's');
        if isempty(newLocation)
            newLocation = listings{listingIndex, 5};
        end
        % Update the listing
        listings{listingIndex, 2} = newItem;
        listings{listingIndex, 3} = newPrice;
        listings{listingIndex, 4} = newCondition;
        listings{listingIndex, 5} = newLocation;
        fprintf("Listing updated successfully!\n");
case 6   % Find Best Matches
   if ~exist('listings', 'var') || isempty(listings)
       fprintf("No listings available to match.\n");
       continue;
   end
   if ~exist('users', 'var') || isempty(users)
       fprintf("No user preferences available. Please register first.\n");
       continue;
   end
   % Directly call bestMatches without asking for email again
   bestMatches(users, listings);
    case 7   % Simulate Transaction
  if isempty(listings)
      fprintf("No listings available for transaction.\n");
      continue;  % Skip this iteration if no listings are present
  end
  % Get buyer and seller emails
  buyerEmail = input('Enter your email (Buyer): ', 's');
  buyerIndex = find(strcmp(users(:, 2), buyerEmail), 1);
  if isempty(buyerIndex)
      fprintf('Buyer not found. Please register or try again.\n');
      continue;
  end
   sellerEmail = input('Enter the seller email: ', 's');
  sellerIndex = find(strcmp(users(:, 2), sellerEmail), 1);
  if isempty(sellerIndex)
      fprintf('Seller not found. Please register or try again.\n');
      continue;
  end
  % Get the item the buyer wants to purchase
  itemName = input('Enter the item name you wish to buy: ', 's');
  itemIndex = find(strcmp({listings(:, 2)}, itemName), 1);  % Find item by name
   if isempty(itemIndex)
      fprintf('Item not found.\n');
      continue;
  end
   % Fetch item details
  itemPrice = listings{itemIndex, 3};
  itemCondition = listings{itemIndex, 4};
  itemLocation = listings{itemIndex, 5};
   % Ensure the buyer's balance exists, if not, initialize it
  if size(users, 2) < 7
      fprintf('Error: User data is incomplete. Balance not initialized.\n');
      continue;
  end
   % Fetch buyer's balance (assuming balance is stored in the 7th column)
  buyerBalance = users{buyerIndex, 7};
   if buyerBalance < itemPrice
      fprintf('Insufficient funds. Transaction aborted.\n');
      continue;
  end
   % Perform transaction
  % Deduct item price from buyer's balance
  users{buyerIndex, 7} = buyerBalance - itemPrice;
   % Ensure the inventory exists for the buyer; if not, initialize it
  if size(users, 2) < 8
      users{buyerIndex, 8} = struct('inventory', {});  % Initialize an empty inventory structure
  end
  % Add item to buyer's inventory
  users{buyerIndex, 8}.inventory = [users{buyerIndex, 8}.inventory, itemName];
   % Remove the item from the listings (simulating that it's been sold)
  listings(itemIndex, :) = [];
   % Display confirmation
  fprintf('\nTransaction Successful!\n');
  fprintf('Buyer: %s\nSeller: %s\nItem: %s\nPrice: $%.2f\nCondition: %s\nLocation: %s\n\n', ...
      users{buyerIndex, 1}, users{sellerIndex, 1}, itemName, itemPrice, itemCondition, itemLocation);
fprintf('Buyer''s remaining balance: $%.2f\n', users{buyerIndex, 7});
   case 8  % Set Preferences
  % Ensure that the users array is not empty and has at least 4 columns
  if isempty(users) || size(users, 2) < 4
      fprintf('No users registered yet or invalid data structure.\n');
      continue;  % Skip if no users or incorrect data structure
  end
  % Get the email of the user whose preferences are to be updated
  email = input('Enter your email: ', 's');
  userIndex = find(strcmp(users(:, 2), email), 1);
   if isempty(userIndex)
      fprintf('User not found. Please register first.\n');
      continue;  % Skip if the user is not found
  end
   % Display current preferences
  fprintf('\nCurrent Preferences for %s:\n', users{userIndex, 1});
  preferences = users{userIndex, 4};  % Assume preferences are stored in column 4
   fprintf('Price Range: $%.2f - $%.2f\n', preferences.PriceRange(1), preferences.PriceRange(2));
  fprintf('Preferred Category: %s\n', preferences.Category);
  fprintf('Preferred Condition: %s\n', preferences.Condition);
   % Ask the user if they want to update their preferences
  update = input('\nWould you like to update your preferences? (y/n): ', 's');
   if lower(update) == 'y'
      % Get new preferences from the user
      fprintf('\nEnter new preferences:\n');
    
      minPrice = input('Enter new min price: ');
      maxPrice = input('Enter new max price: ');
      category = input('Enter preferred category: ', 's');
      condition = input('Enter preferred condition: ', 's');
    
      % Store new preferences
      users{userIndex, 4} = struct('PriceRange', [minPrice, maxPrice], ...
                                   'Category', category, ...
                                   'Condition', condition);
    
      fprintf('Your preferences have been updated.\n');
  else
      fprintf('No changes were made to your preferences.\n');
  end
    case 9  % Exit
        fprintf("Exiting program...\n");
        break; % Exit loop
    otherwise
        fprintf("Invalid choice. Please enter a number between 1 and 9.\n");
end
end
