% matching_system_fixed.m - Improved Matching System with Cell Arrays
function bestMatches = find_best_matches(users, listings)
  if isempty(users) || isempty(listings)
      fprintf('No users or listings available.\n');
      return;
  end
  % Identify user by email for consistency with other functions
  userEmail = input('Enter your registered email: ', 's');
  userIndex = find(strcmp(users(:, 2), userEmail), 1);
  if isempty(userIndex)
      fprintf('User not found.\n');
      return;
  end
  % Extract user preferences from the struct format
  preferences = users{userIndex, 4};
  preferredCategory = preferences.Category;
  maxPrice = preferences.PriceRange(2); % Upper limit of price range
  preferredLocation = users{userIndex, 3}; % User's saved location
  % Initialize and calculate match scores
  scores = calculate_match_scores(listings, preferredCategory, maxPrice, preferredLocation);
  % Sort listings by score in descending order
  [~, sortedIndices] = sort(scores, 'descend');
  % Display top matches
  fprintf('\nBest Matches for You:\n');
  bestMatches = {};
  matchCount = 0;
  for i = 1:min(5, length(sortedIndices))
      idx = sortedIndices(i);
      if scores(idx) > 0
          matchCount = matchCount + 1;
          bestMatches = [bestMatches; listings(idx, :)];
          fprintf('%d. %s - $%.2f (%s) - Score: %d\n', ...
              matchCount, listings{idx, 2}, listings{idx, 3}, listings{idx, 4}, scores(idx));
      end
  end
  if matchCount == 0
      fprintf('No suitable matches found based on your preferences.\n');
  end
end
function scores = calculate_match_scores(listings, preferredCategory, maxPrice, preferredLocation)
  scores = zeros(size(listings, 1), 1);
  for i = 1:size(listings, 1)
      score = 0;
      % Category match (higher weight)
      if strcmp(listings{i, 4}, preferredCategory)
          score = score + 50;
      end
      % Price match (proportional scoring)
      if listings{i, 3} <= maxPrice
          score = score + round((maxPrice - listings{i, 3}) / maxPrice * 30);
      end
      % Location match (minor bonus)
      if strcmp(listings{i, 5}, preferredLocation)
          score = score + 20;
      end
      scores(i) = score;
  end
end
