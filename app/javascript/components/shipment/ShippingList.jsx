import React from "react";
import fetchApi from "../lib/Fetch";
import { Table } from "react-bootstrap";
import { ToastContainer, toast } from 'react-toastify';

class ShippingList extends React.Component {
  self = this;
  onRemoveFromShippingList(robot, index, category) {
    this.props.onRemoveFromShippingList(robot, index, category);
  }

  sendShipment() {
    fetchApi("/shipments/create", "PUT",
      { robot_ids: this.props.robots.map((e) => e.id) },
      this.onSuccess,
      this.onFailure
    );
  }

  onRobotShipped(robot_ids) {
    this.props.onShipped(robot_ids)
  }

  onSuccess = (response) => {
    toast.success(`Robots ${ response.robot_ids.join(', ') } is shipped successfully.`)
    this.onRobotShipped(response.robot_ids);
  }

  onFailure = (response) => {
    toast.error(response.error);
  }

  renderRobots() {
    const {index, category} = this.props;
    let robots = this.props.robots.map((robot) => {
      return(
        <tr key={robot.id} className={`shipping-list-robot-${robot.id}`}>
          <td>
            <button
              className="btn btn-danger"
              onClick={this.onRemoveFromShippingList.bind(this, robot, index, category)}>
              Remove from shipment
            </button>
          </td>
          <td>{robot.id}</td>
          <td>{robot.name}</td>
          <td>{robot.configuration.hasSentience ? 'Yes' : 'No'}</td>
          <td>{robot.configuration.hasWheels ? 'Yes' : 'No'}</td>
          <td>{robot.configuration.hasTracks ? 'Yes' : 'No'}</td>
          <td>{robot.configuration.numberOfRotors}</td>
          <td>{robot.configuration.color}</td>
          <td>{robot.configuration.statuses.join(', ')}</td>
        </tr>
      )
    });

    return robots;
  }

  render() {
    return(
      <div className="shipping-list">
        <h3>Ready to ship
          <button
            disabled={!this.props.robots.length}
            className="btn btn-success pull-right"
            onClick={ this.sendShipment.bind(this) }>
            Send shipment
          </button>
        </h3>
        <div className="table-responsive">
          <Table>
            <thead>
              <tr>
                <th>Action</th>
                <th>ID</th>
                <th>Name</th>
                <th>Has Sentience</th>
                <th>Has Wheels</th>
                <th>Has Tracks</th>
                <th>Number of rotors</th>
                <th>Color</th>
                <th>Statuses</th>
              </tr>
            </thead>
            <tbody>
              { this.renderRobots() }
            </tbody>
          </Table>
        </div>
        <ToastContainer/>
      </div>
    );
  }
}

export default ShippingList;
