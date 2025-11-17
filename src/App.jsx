import { useState } from 'react';
import Header from './components/Header';
import FoodTruckList from './components/FoodTruckList';
import FoodTruckForm from './components/FoodTruckForm';
import Map from './components/Map';
import { initialFoodTrucks } from './data/foodTrucks';
import './App.css';

function App() {
  const [trucks, setTrucks] = useState(initialFoodTrucks);
  const [selectedTruck, setSelectedTruck] = useState(null);
  const [editingTruck, setEditingTruck] = useState(null);
  const [showForm, setShowForm] = useState(false);

  // Create new truck
  const handleAddTruck = (truckData) => {
    const newTruck = {
      ...truckData,
      id: Math.max(...trucks.map((t) => t.id), 0) + 1
    };
    setTrucks([...trucks, newTruck]);
    setShowForm(false);
  };

  // Update existing truck
  const handleUpdateTruck = (truckData) => {
    setTrucks(trucks.map((t) => (t.id === truckData.id ? truckData : t)));
    setEditingTruck(null);
    setSelectedTruck(truckData);
  };

  // Delete truck
  const handleDeleteTruck = (id) => {
    if (window.confirm('Are you sure you want to delete this food truck?')) {
      setTrucks(trucks.filter((t) => t.id !== id));
      if (selectedTruck?.id === id) {
        setSelectedTruck(null);
      }
    }
  };

  // Select truck (for map interaction)
  const handleSelectTruck = (truck) => {
    setSelectedTruck(truck);
  };

  // Start editing
  const handleEditTruck = (truck) => {
    setEditingTruck(truck);
    setShowForm(false);
  };

  // Cancel editing/adding
  const handleCancel = () => {
    setEditingTruck(null);
    setShowForm(false);
  };

  return (
    <div className="app">
      <Header />

      <main className="main-content">
        <div className="content-grid">
          <div className="left-panel">
            <div className="panel-header">
              <h2>Food Trucks ({trucks.length})</h2>
              {!showForm && !editingTruck && (
                <button
                  className="btn btn-add"
                  onClick={() => setShowForm(true)}
                >
                  + Add New
                </button>
              )}
            </div>

            {showForm && (
              <FoodTruckForm onSubmit={handleAddTruck} onCancel={handleCancel} />
            )}

            {editingTruck && (
              <FoodTruckForm
                initialData={editingTruck}
                onSubmit={handleUpdateTruck}
                onCancel={handleCancel}
              />
            )}

            <FoodTruckList
              trucks={trucks}
              onEdit={handleEditTruck}
              onDelete={handleDeleteTruck}
              onSelect={handleSelectTruck}
              selectedTruck={selectedTruck}
            />
          </div>

          <div className="right-panel">
            <div className="panel-header">
              <h2>Map View</h2>
            </div>
            <div className="map-wrapper">
              <Map
                trucks={trucks}
                selectedTruck={selectedTruck}
                onMarkerClick={handleSelectTruck}
              />
            </div>
          </div>
        </div>
      </main>
    </div>
  );
}

export default App;
