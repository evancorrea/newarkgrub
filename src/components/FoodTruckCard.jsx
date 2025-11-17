import './FoodTruckCard.css';

function FoodTruckCard({ truck, onEdit, onDelete, onSelect, isSelected }) {
  return (
    <div
      className={`food-truck-card ${isSelected ? 'selected' : ''}`}
      onClick={() => onSelect(truck)}
    >
      <div className="card-header">
        <h3 className="truck-name">{truck.name}</h3>
        <span className="cuisine-badge">{truck.cuisine}</span>
      </div>

      <p className="truck-description">{truck.description}</p>

      <div className="truck-details">
        <div className="detail-item">
          <span className="detail-label">Rating:</span>
          <span className="rating">
            {'⭐'.repeat(Math.floor(truck.rating))} {truck.rating}
          </span>
        </div>
        <div className="detail-item">
          <span className="detail-label">Price:</span>
          <span className="price">{truck.priceRange}</span>
        </div>
        <div className="detail-item">
          <span className="detail-label">Hours:</span>
          <span>{truck.hours}</span>
        </div>
        <div className="detail-item">
          <span className="detail-label">Phone:</span>
          <span>{truck.phone}</span>
        </div>
        <div className="detail-item">
          <span className="detail-label">Location:</span>
          <span>{truck.location.address}</span>
        </div>
      </div>

      <div className="card-actions">
        <button
          className="btn btn-edit"
          onClick={(e) => {
            e.stopPropagation();
            onEdit(truck);
          }}
        >
          Edit
        </button>
        <button
          className="btn btn-delete"
          onClick={(e) => {
            e.stopPropagation();
            onDelete(truck.id);
          }}
        >
          Delete
        </button>
      </div>
    </div>
  );
}

export default FoodTruckCard;
