# NewarkGrub

A React-based CRUD application for discovering and managing food trucks in Newark, NJ. Features Google Maps integration to visualize food truck locations.

## Features

- **View** all food trucks with details (cuisine, rating, hours, location)
- **Add** new food trucks to the directory
- **Edit** existing food truck information
- **Delete** food trucks from the listing
- **Interactive Map** showing food truck locations with clickable markers
- **Responsive Design** that works on desktop and mobile devices

## Tech Stack

- React 18
- Vite (build tool)
- @react-google-maps/api (Google Maps integration)
- CSS (custom styling)

## Getting Started

### Prerequisites

- Node.js (v16 or higher)
- npm or yarn

### Installation

1. Clone the repository:
```bash
git clone https://github.com/yourusername/newarkgrub.git
cd newarkgrub
```

2. Install dependencies:
```bash
npm install
```

3. (Optional) Configure Google Maps API:
   - Copy `.env.example` to `.env`
   - Add your Google Maps API key:
   ```
   VITE_GOOGLE_MAPS_API_KEY=your_api_key_here
   ```
   - Get an API key from [Google Cloud Console](https://console.cloud.google.com/google/maps-apis)
   - Enable the Maps JavaScript API

4. Start the development server:
```bash
npm run dev
```

5. Open your browser and visit `http://localhost:5173`

## Usage

### Viewing Food Trucks
- Browse the list of food trucks on the left panel
- Click on any truck card to highlight its location on the map
- View details including cuisine type, rating, hours, and contact information

### Adding a Food Truck
- Click the "+ Add New" button
- Fill in the required information
- Click "Add Food Truck" to save

### Editing a Food Truck
- Click the "Edit" button on any food truck card
- Modify the information as needed
- Click "Update Food Truck" to save changes

### Deleting a Food Truck
- Click the "Delete" button on any food truck card
- Confirm the deletion in the popup dialog

### Map Interaction
- Click on map markers to view food truck information
- Selected trucks are highlighted with an orange marker
- The map automatically centers on the selected truck

## Project Structure

```
newarkgrub/
├── src/
│   ├── components/
│   │   ├── Header.jsx        # App header component
│   │   ├── FoodTruckList.jsx # List of all food trucks
│   │   ├── FoodTruckCard.jsx # Individual truck card
│   │   ├── FoodTruckForm.jsx # Add/Edit form
│   │   └── Map.jsx           # Google Maps integration
│   ├── data/
│   │   └── foodTrucks.js     # Dummy data for demo
│   ├── App.jsx               # Main app component
│   ├── main.jsx              # App entry point
│   └── index.css             # Global styles
├── index.html
├── package.json
└── vite.config.js
```

## Development

### Available Scripts

- `npm run dev` - Start development server
- `npm run build` - Build for production
- `npm run preview` - Preview production build
- `npm run lint` - Run ESLint

### Note on Google Maps

The app works without a Google Maps API key - it will display a placeholder showing food truck locations. For full map functionality, add your API key to the `.env` file.

## Demo Data

The app comes with 6 sample food trucks located around Newark, NJ:
- Newark Taco Express (Mexican)
- Brick City BBQ (BBQ)
- Jersey Gyro King (Mediterranean)
- Aloha Poke Bowl (Hawaiian)
- Sweet Street Desserts (Desserts)
- Philly Cheesesteak Co (American)

## License

This project is licensed under the MIT License - see the LICENSE file for details.
