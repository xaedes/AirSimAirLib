// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License.

#ifndef air_CarRpcLibClient_hpp
#define air_CarRpcLibClient_hpp

#include "AirSimAirLib/common/Common.hpp"
#include <functional>
#include "AirSimAirLib/common/CommonStructs.hpp"
#include "AirSimAirLib/vehicles/car/api/CarApiBase.hpp"
#include "AirSimAirLib/api/RpcLibClientBase.hpp"
#include "AirSimAirLib/common/ImageCaptureBase.hpp"

namespace msr
{
namespace airlib
{

    class CarRpcLibClient : public RpcLibClientBase
    {
    public:
        CarRpcLibClient(const string& ip_address = "localhost", uint16_t port = RpcLibPort, float timeout_sec = 60);

        void setCarControls(const CarApiBase::CarControls& controls, const std::string& vehicle_name = "");
        CarApiBase::CarState getCarState(const std::string& vehicle_name = "");
        CarApiBase::CarControls getCarControls(const std::string& vehicle_name = "");
        virtual ~CarRpcLibClient(); //required for pimpl
    };
}
} //namespace
#endif
