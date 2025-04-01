clc;
clear;
close all;
% Define save directory and file
saveDir = fullfile('..', 'data'); % Ensure cross-platform compatibility
saveFile = fullfile(saveDir, 'listings.mat');

% Ensure the directory exists
if ~exist(saveDir, 'dir')
    mkdir(saveDir);
end

% Ask user whether to use old save data or create a new one
choice = input("Use existing listings data? (y/n): ", 's');

if strcmpi(choice, 'y') && exist(saveFile, 'file')
    % Load existing listings data
    load(saveFile, 'listings');
    disp("Loaded existing listings data.");
else
    % Create a new save file
    listings = {}; % Initialize an empty cell array
    save(saveFile, 'listings'); % Save the empty file
    disp("Created a new listings data file.");
end

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
        condition = input("Enter preferred condition: (New, Good, Fair, Like New, Any):  ", 's');
        % Store price range as a 2-element vector
        priceRange = [minPrice, maxPrice];
        % Register user
        users = registerUser(users, name, email, location, priceRange, category, condition);

    case 2  % Display Users
    displayUsers(users);

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

    case 4  % Search Items
    listings = searchItems(listings);

   case 5  % Edit Listing
    listings = editListing(listings);

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

    % Get buyer email
    buyerEmail = input('Enter your email (Buyer): ', 's');
    
    % Get item name
    itemName = input('Enter the item name you wish to buy: ', 's');
    
    % Call the function to handle the transaction
    listings = simulateTransaction(listings, itemName, buyerEmail, users);

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
  % Call the preferences function
  users = preferences(users, userIndex);  % Update user preferences

    case 9  % Exit
        fprintf("Exiting program...\n");
        break; % Exit loop
    otherwise
        fprintf("Invalid choice. Please enter a number between 1 and 9.\n");
end
end
