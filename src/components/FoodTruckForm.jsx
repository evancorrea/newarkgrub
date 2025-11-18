import { useState, useEffect } from 'react';
import './FoodTruckForm.css';

function FoodTruckForm({ onSubmit, initialData, onCancel }) {
  const [formData, setFormData] = useState({
    name: '',
    cuisine: '',
    description: '',
    rating: 4.0,
    priceRange: '$$',
    hours: '',
    phone: '',
    location: {
      lat: 40.735657,
      lng: -74.172367,
      address: ''
    }
  });

  useEffect(() => {
    if (initialData) {
      setFormData(initialData);
    }
  }, [initialData]);

  const handleChange = (e) => {
    const { name, value } = e.target;
    if (name.startsWith('location.')) {
      const locationField = name.split('.')[1];
      setFormData((prev) => ({
        ...prev,
        location: {
          ...prev.location,
          [locationField]: locationField === 'lat' || locationField === 'lng'
            ? parseFloat(value)
            : value
        }
      }));
    } else {
      setFormData((prev) => ({
        ...prev,
        [name]: name === 'rating' ? parseFloat(value) : value
      }));
    }
  };

  const handleSubmit = (e) => {
    e.preventDefault();
    onSubmit(formData);
    if (!initialData) {
      setFormData({
        name: '',
        cuisine: '',
        description: '',
        rating: 4.0,
        priceRange: '$$',
        hours: '',
        phone: '',
        location: {
          lat: 40.735657,
          lng: -74.172367,
          address: ''
        }
      });
    }
  };

  return (
    <form className="food-truck-form" onSubmit={handleSubmit}>
      <h3>{initialData ? 'Edit Food Truck' : 'Add New Food Truck'}</h3>

      <div className="form-group">
        <label htmlFor="name">Name *</label>
        <input
          type="text"
          id="name"
          name="name"
          value={formData.name}
          onChange={handleChange}
          required
          placeholder="Food truck name"
        />
      </div>

      <div className="form-group">
        <label htmlFor="cuisine">Cuisine Type *</label>
        <input
          type="text"
          id="cuisine"
          name="cuisine"
          value={formData.cuisine}
          onChange={handleChange}
          required
          placeholder="e.g., Mexican, BBQ, Italian"
        />
      </div>

      <div className="form-group">
        <label htmlFor="description">Description *</label>
        <textarea
          id="description"
          name="description"
          value={formData.description}
          onChange={handleChange}
          required
          placeholder="Describe the food truck..."
          rows="3"
        />
      </div>

      <div className="form-row">
        <div className="form-group">
          <label htmlFor="rating">Rating (1-5)</label>
          <input
            type="number"
            id="rating"
            name="rating"
            value={formData.rating}
            onChange={handleChange}
            min="1"
            max="5"
            step="0.1"
          />
        </div>

        <div className="form-group">
          <label htmlFor="priceRange">Price Range</label>
          <select
            id="priceRange"
            name="priceRange"
            value={formData.priceRange}
            onChange={handleChange}
          >
            <option value="$">$ (Budget)</option>
            <option value="$$">$$ (Moderate)</option>
            <option value="$$$">$$$ (Premium)</option>
          </select>
        </div>
      </div>

      <div className="form-group">
        <label htmlFor="hours">Operating Hours *</label>
        <input
          type="text"
          id="hours"
          name="hours"
          value={formData.hours}
          onChange={handleChange}
          required
          placeholder="e.g., 11:00 AM - 9:00 PM"
        />
      </div>

      <div className="form-group">
        <label htmlFor="phone">Phone Number *</label>
        <input
          type="tel"
          id="phone"
          name="phone"
          value={formData.phone}
          onChange={handleChange}
          required
          placeholder="(973) 555-0100"
        />
      </div>

      <div className="form-group">
        <label htmlFor="location.address">Location Address *</label>
        <input
          type="text"
          id="location.address"
          name="location.address"
          value={formData.location.address}
          onChange={handleChange}
          required
          placeholder="Street address in Newark, NJ"
        />
      </div>

      <div className="form-row">
        <div className="form-group">
          <label htmlFor="location.lat">Latitude</label>
          <input
            type="number"
            id="location.lat"
            name="location.lat"
            value={formData.location.lat}
            onChange={handleChange}
            step="0.000001"
          />
        </div>

        <div className="form-group">
          <label htmlFor="location.lng">Longitude</label>
          <input
            type="number"
            id="location.lng"
            name="location.lng"
            value={formData.location.lng}
            onChange={handleChange}
            step="0.000001"
          />
        </div>
      </div>

      <div className="form-actions">
        <button type="submit" className="btn btn-primary">
          {initialData ? 'Update' : 'Add'} Food Truck
        </button>
        {onCancel && (
          <button type="button" className="btn btn-secondary" onClick={onCancel}>
            Cancel
          </button>
        )}
      </div>
    </form>
  );
}

export default FoodTruckForm;
