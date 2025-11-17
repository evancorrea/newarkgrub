import FoodTruckCard from './FoodTruckCard';
import './FoodTruckList.css';

function FoodTruckList({ trucks, onEdit, onDelete, onSelect, selectedTruck }) {
  if (trucks.length === 0) {
    return (
      <div className="empty-state">
        <p>No food trucks found. Add one to get started!</p>
      </div>
    );
  }

  return (
    <div className="food-truck-list">
      {trucks.map((truck) => (
        <FoodTruckCard
          key={truck.id}
          truck={truck}
          onEdit={onEdit}
          onDelete={onDelete}
          onSelect={onSelect}
          isSelected={selectedTruck?.id === truck.id}
        />
      ))}
    </div>
  );
}

export default FoodTruckList;
