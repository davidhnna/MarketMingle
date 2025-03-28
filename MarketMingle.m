clc;
clear;
close all;
% Define save directory and file
saveDir = '../data';
saveFile = fullfile(saveDir, 'users.mat');
% Load existing user data if available
if exist(saveFile, 'file')
   load(saveFile, 'users');
else
   users = {};  % Initialize an empty cell array if file doesn't exist
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
           % Get user email for matching
           userEmail = input("Enter your email to find best matches: ", 's');
          
           % Find user in the database
           userIndex = -1;
           for i = 1:size(users, 1)
               if strcmp(users{i, 2}, userEmail)
                   userIndex = i;
                   break;
               end
           end
           if userIndex == -1
               fprintf("User not found. Please register first.\n");
               continue;
           end
           % Ensure user has enough attributes before accessing them
           if size(users, 2) < 6
               fprintf("Error: Incomplete user data. Please register again.\n");
               continue;
           end
           % Retrieve user preferences safely
           preferredCategory = users{userIndex, 5};
           preferredCondition = users{userIndex, 6};
           priceRange = users{userIndex, 4}; % [minPrice, maxPrice]
           % Handle cases where priceRange is not a 2-element vector
           if ~isnumeric(priceRange) || length(priceRange) ~= 2
               fprintf("Error: Invalid price range for user.\n");
               continue;
           end
           fprintf("\nSearching for best matches...\n");
           found = false;
           % Search listings based on user preferences
           for i = 1:size(listings, 1)
               listing = listings(i, :);
               itemName = listing{2};
               itemPrice = listing{3};
               itemCondition = listing{4};
               % Check if listing matches user preferences
               if (itemPrice >= priceRange(1) && itemPrice <= priceRange(2)) && ...
                  (strcmpi(preferredCondition, 'Any') || strcmpi(itemCondition, preferredCondition))
                  
                   % Display matching listing
                   fprintf("Seller: %s | Item: %s | Price: %.2f | Condition: %s | Location: %s\n", ...
                           listing{1}, itemName, itemPrice, itemCondition, listing{5});
                   found = true;
               end
           end
           if ~found
               fprintf("No suitable matches found.\n");
           end
       case 7  % Simulate Transaction
           fprintf("Feature not implemented yet.\n"); % Placeholder
       case 8  % Set Preferences
           fprintf("Feature not implemented yet.\n"); % Placeholder
       case 9  % Exit
           fprintf("Exiting program...\n");
           break; % Exit loop
       otherwise
           fprintf("Invalid choice. Please enter a number between 1 and 9.\n");
   end
end
