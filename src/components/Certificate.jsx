import React, { useState } from "react"
import { Modal, IconButton, Box, Backdrop, Typography } from "@mui/material"
import CloseIcon from "@mui/icons-material/Close"
import FullscreenIcon from "@mui/icons-material/Fullscreen"

const Certificate = ({ ImgSertif }) => {
    const [open, setOpen] = useState(false)

    const handleOpen = () => setOpen(true)
    const handleClose = () => setOpen(false)

    return (
        <>
            {/* FRAME LUAR (Desain Bingkai Elegan) */}
            <div 
                className="w-full relative group bg-[#1a1a2e]/80 backdrop-blur-sm border border-slate-700/50 rounded-2xl p-4 sm:p-5 transition-all duration-300 hover:-translate-y-2 hover:border-indigo-500/50 hover:shadow-[0_8px_30px_rgb(99,102,241,0.15)] cursor-pointer"
                onClick={handleOpen}
            >
                {/* CONTAINER GAMBAR */}
                <div className="relative overflow-hidden rounded-lg">
                    {/* Gambar Sertifikat */}
                    <img
                        src={ImgSertif}
                        alt="Certificate"
                        className="w-full h-auto object-cover transition-transform duration-500 group-hover:scale-105"
                        style={{ aspectRatio: "16/11.5" }}
                        loading="lazy"
                    />
                    
                    {/* Overlay "View Certificate" saat di-hover */}
                    <div className="absolute inset-0 bg-black/60 opacity-0 group-hover:opacity-100 transition-opacity duration-300 flex flex-col items-center justify-center z-10">
                        <FullscreenIcon sx={{ fontSize: 40, color: "white", mb: 1, filter: "drop-shadow(0 2px 4px rgba(0,0,0,0.5))" }} />
                        <Typography
                            variant="h6"
                            sx={{ color: "white", fontWeight: 600, textShadow: "0 2px 4px rgba(0,0,0,0.5)" }}
                        >
                            View Certificate
                        </Typography>
                    </div>
                </div>
            </div>

            {/* MODAL FULLSCREEN (Fitur Asli Kamu, Tidak Diubah) */}
            <Modal
                open={open}
                onClose={handleClose}
                aria-labelledby="modal-modal-title"
                aria-describedby="modal-modal-description"
                BackdropComponent={Backdrop}
                BackdropProps={{
                    timeout: 300,
                    sx: {
                        backgroundColor: "rgba(0, 0, 0, 0.9)",
                        backdropFilter: "blur(5px)",
                    },
                }}
                sx={{
                    display: "flex",
                    alignItems: "center",
                    justifyContent: "center",
                    margin: 0,
                    padding: 0,
                }}
            >
                <Box
                    sx={{
                        position: "relative",
                        width: "auto",
                        maxWidth: "90vw",
                        maxHeight: "90vh",
                        m: 0,
                        p: 0,
                        outline: "none",
                    }}
                >
                    <IconButton
                        onClick={handleClose}
                        sx={{
                            position: "absolute",
                            right: 16,
                            top: 16,
                            color: "white",
                            bgcolor: "rgba(0,0,0,0.6)",
                            zIndex: 1,
                            padding: 1,
                            "&:hover": {
                                bgcolor: "rgba(0,0,0,0.8)",
                                transform: "scale(1.1)",
                            },
                        }}
                        size="large"
                    >
                        <CloseIcon sx={{ fontSize: 24 }} />
                    </IconButton>

                    <img
                        src={ImgSertif}
                        alt="Certificate Full View"
                        style={{
                            display: "block",
                            maxWidth: "100%",
                            maxHeight: "90vh",
                            margin: "0 auto",
                            objectFit: "contain",
                        }}
                    />
                </Box>
            </Modal>
        </>
    )
}

export default Certificate